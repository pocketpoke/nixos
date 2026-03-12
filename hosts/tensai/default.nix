{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core
    ../../modules/boot
    ../../modules/hardware
    ../../modules/desktop
    ../../modules/networking
    ../../modules/services
    ../../modules/shell
    ../../modules/users
  ];

  networking.hostName = "tensai";

  system.stateVersion = "25.05";
}
