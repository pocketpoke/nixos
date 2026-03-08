{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Core
    ../../modules/_core

    # Boot & storage
    ../../modules/boot

    # Hardware features
    ../../modules/hardware

    # Desktop / GUI
    ../../modules/desktop

    # Networking
    ../../modules/networking

    # Services & programs
    ../../modules/services

    # Users
    ../../modules/users
  ];

  networking.hostName = "tensai";

  system.stateVersion = "25.05";
}
