{ inputs, ... }:
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
  ];

  networking.hostName = "tensai";
  system.stateVersion = "25.05";

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    unstablePkgs = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
  home-manager.sharedModules = [ inputs.sops-nix.homeManagerModules.sops ];

  home-manager.users.user = {
    imports = [
      inputs.plasma-manager.homeModules.plasma-manager
      inputs.vast-cli.homeManagerModules.default
      ../../modules/home/packages.nix
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
