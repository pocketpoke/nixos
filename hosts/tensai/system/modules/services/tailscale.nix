{ ... }:

{
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client"; # “server” if you run a subnet router

  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.checkReversePath = "loose";
}
