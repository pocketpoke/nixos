{ inputs, ... }:
let
  unstablePkgs = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
    config.nvidia.acceptLicense = true;
  };
in
{
  imports = [
    ./hardware.nix
    ../../pkgs/default.nix
    ../../modules/system/boot.nix
    ../../modules/system/storage.nix
    ../../modules/system/networking.nix
    ../../modules/system/graphics.nix
    ../../modules/system/audio.nix
    ../../modules/system/services.nix
    ../../modules/system/nix.nix
    ../../modules/system/locale.nix
    ../../modules/system/fonts.nix
    ../../modules/system/shell.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.aerothemeplasma-nix.nixosModules.aerothemeplasma-nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  nixpkgs.overlays = [
    inputs.affinity-nix.overlays.default
    (_final: _prev: {
      kdePackages = unstablePkgs.kdePackages;
    })
  ];

  networking.hostName = "tensai";

  # AeroThemePlasma: a Windows 7/Aero-style Plasma session.
  programs.aeroshell = {
    enable = true;
    fonts.segoe.enable = true;
    polkit.enable = true;
    sessions.wayland.enable = true;
    sessions.x11.enable = false;
    aerothemeplasma = {
      enable = true;
      sddm.enable = true;
      plymouth.enable = true;
    };
  };

  services.displayManager.defaultSession = "aerothemeplasma";

  system.stateVersion = "26.05";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    unstablePkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
      config.nvidia.acceptLicense = true;
    };
  };
  home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

  home-manager.users.user = {
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
      inputs.vast-cli.homeManagerModules.default
      ../../modules/home/packages.nix
      ../../modules/home/hermes.nix
      ../../modules/home/git.nix
      ../../modules/home/vscode.nix
      ../../modules/home/plasma.nix
      ../../modules/home/theming.nix
      ../../modules/home/desktop-entries.nix
      ../../modules/home/secrets.nix
      ../../modules/home/vastai.nix
    ];

    home.username = "user";
    home.homeDirectory = "/home/user";
    home.stateVersion = "25.05";
  };
}
