{ ... }: {
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";

  networking.firewall.allowedUDPPorts = [ 41641 ];
  networking.firewall.checkReversePath = "loose";
}
