{ config, lib, pkgs, ... }:

let
  hotspotRoutingScript = pkgs.writeShellScript "poweredge-phone-hotspot-routing" ''
    set -u

    WIFI_IF="wlp9s0f3u2i2"
    LAN_IF="enp7s0"
    LAN_NET="192.168.50.0/24"
    LAN_ADDR="192.168.50.10"
    TABLE="100"
    RULE_PREF="1000"
    IP="${pkgs.iproute2}/bin/ip"
    AWK="${pkgs.gawk}/bin/awk"
    IPTABLES="${pkgs.iptables}/bin/iptables"

    while true; do
      WIFI_NET="$($IP -4 route show dev "$WIFI_IF" proto kernel scope link | "$AWK" 'NR == 1 { print $1 }')"
      WIFI_GW="$($IP -4 route show default dev "$WIFI_IF" | "$AWK" 'NR == 1 { print $3 }')"

      if [ -n "$WIFI_NET" ] && [ -n "$WIFI_GW" ]; then
        $IP route replace "$WIFI_NET" dev "$WIFI_IF" src "$LAN_ADDR" table "$TABLE"
        $IP route replace "$LAN_NET" dev "$LAN_IF" src "$LAN_ADDR" table "$TABLE"
        $IP route replace default via "$WIFI_GW" dev "$WIFI_IF" table "$TABLE"

        if ! $IP rule list | grep -q "^[[:space:]]*$RULE_PREF:.*from $LAN_NET lookup $TABLE"; then
          $IP rule add pref "$RULE_PREF" from "$LAN_NET" table "$TABLE"
        fi
      fi

      add_rule() {
        if ! $IPTABLES -C "$@" 2>/dev/null; then
          $IPTABLES -I 1 "$@"
        fi
      }

      add_rule FORWARD -i "$LAN_IF" -o "$WIFI_IF" -s "$LAN_NET" -j ACCEPT
      add_rule FORWARD -i "$WIFI_IF" -o "$LAN_IF" -d "$LAN_NET" -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

      if ! $IPTABLES -t nat -C POSTROUTING -s "$LAN_NET" -o "$WIFI_IF" -j MASQUERADE 2>/dev/null; then
        $IPTABLES -t nat -A POSTROUTING -s "$LAN_NET" -o "$WIFI_IF" -j MASQUERADE
      fi

      sleep 30
    done
  '';
in
{
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  systemd.services.poweredge-phone-hotspot-routing = {
    description = "Route PowerEdge traffic through the phone hotspot";
    wantedBy = [ "multi-user.target" ];
    wants = [ "NetworkManager-wait-online.service" ];
    after = [ "NetworkManager-wait-online.service" "tailscaled.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = hotspotRoutingScript;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
