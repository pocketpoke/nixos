{
  pkgs,
  config,
  lib,
  ...
}:

{
  home.packages = with pkgs; [
    chatterino2
    thunderbird
    signal-desktop
    # telegram-desktop
  ];

  sops = {
    defaultSopsFile = ../../../secrets/chatterino2-settings.json;

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.chatterino2-settings = {
      path =
        if pkgs.stdenv.hostPlatform.isDarwin then
          "${config.home.homeDirectory}/Library/Application Support/chatterino/settings.json"
        else
          "${config.home.homeDirectory}/.local/share/chatterino/settings.json";
    };
  };

  home.activation.ensureChatterinoDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${builtins.dirOf config.sops.secrets.chatterino2-settings.path}"
  '';

  programs.nixcord = {
    enable = true;
    discord.enable = true;

    inherit ((import ./configs/nixcord.nix).programs.nixcord) config;
  };
}
