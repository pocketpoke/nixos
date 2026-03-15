{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    chatterino2
    thunderbird
    signal-desktop
    # telegram-desktop
  ];

  age.secrets.chatterino2-settings = {
    file = ../../../secrets/chatterino2-settings.age;

    path =
      if pkgs.stdenv.hostPlatform.isDarwin then
        "${config.home.homeDirectory}/Library/Application Support/chatterino/settings.json"
      else
        "${config.home.homeDirectory}/.local/share/chatterino/settings.json";

    mode = "0600";
  };

  programs.nixcord = {
    enable = true;
    discord.enable = true;

    inherit ((import ./configs/nixcord.nix).programs.nixcord) config;
  };
}
