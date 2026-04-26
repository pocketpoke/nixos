{
  pkgs,
  inputs,
  unstablePkgs,
  ...
}:
{
  home.packages =
    (with pkgs.kdePackages; [
      kdeconnect-kde
      kzones
      kcalc
      kate
      qtstyleplugin-kvantum
      qt6ct
    ])
    ++ (with pkgs; [
      opencode

      inputs.claude-code.packages.${stdenv.hostPlatform.system}.claude-code
      inputs.codex-cli-nix.packages.${stdenv.hostPlatform.system}.default
      inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
      inputs.antigravity-nix.packages.${stdenv.hostPlatform.system}.default

      unstablePkgs.lmstudio

      stability-matrix

      brave
      librewolf
      mullvad-browser
      tor-browser

      chatterino2
      thunderbird
      signal-desktop
      vesktop

      inputs.affinity-nix.packages.${stdenv.hostPlatform.system}.v3

      nixd
      nixfmt-rfc-style
      nodejs
      gh
      python3

      inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.hytale-launcher

      imgbrd-grabber
      vlc

      nextcloud-client
      wget
      curl

      btop
      fastfetch

      bitwarden-desktop

      parsec-bin

      yazi
      tree

      ffmpeg

      yt-dlp
      twitchlink

      inputs.twitchdownloadercli.packages.${stdenv.hostPlatform.system}.twitchdownloadercli
      inputs.stream-organizer.packages.${stdenv.hostPlatform.system}.default

      pika-backup
      virt-viewer

      gsmartcontrol
      smartmontools

      syncthingtray

      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
    ]);
}
