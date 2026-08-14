{
  pkgs,
  inputs,
  unstablePkgs,
  ...
}:
let
  hermesDesktop = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.desktop;
  cuaDriver = inputs.cua-driver-fork.packages.${pkgs.stdenv.hostPlatform.system}.default;
  hermesDesktopLauncher = pkgs.writeShellScriptBin "hermes-desktop-cua" ''
    export HERMES_CUA_DRIVER_CMD="${cuaDriver}/bin/cua-driver"
    export CUA_DRIVER_RS_ENABLE_WAYLAND=1
    exec "${hermesDesktop}/bin/hermes-desktop" "$@"
  '';
  hermesDesktopEntry = pkgs.makeDesktopItem {
    name = "hermes-agent";
    desktopName = "Hermes Agent";
    comment = "Native desktop client for Hermes Agent";
    exec = "${hermesDesktopLauncher}/bin/hermes-desktop-cua %U";
    icon = "${./../../assets/hermes-agent.png}";
    terminal = false;
    type = "Application";
    categories = [
      "Development"
      "Utility"
    ];
    startupNotify = true;
    startupWMClass = "Hermes";
  };
in
{
  home.packages =
    (with pkgs.kdePackages; [
      kdeconnect-kde
      kzones
      kcalc
      kate
      filelight
      qt6ct
    ])
    ++ (with pkgs; [
      opencode
      codex

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

      pkgs.affinity-v3

      nixd
      nixfmt-rfc-style
      nodejs
      gh

      hermes-cli
      hermesDesktop
      hermesDesktopLauncher
      hermesDesktopEntry
      chromium
      python3Packages.pip
      python3Packages.setuptools
      python3Packages.virtualenv
      gcc
      glibc.dev
      libffi.dev
      zlib.dev
      pkg-config
      gnumake
      python3

      inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.hytale-launcher

      imgbrd-grabber
      vlc

      nextcloud-client
      wget
      curl

      btop
      fastfetch

      qbittorrent

      parsec-bin
      r2modman

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

      libsForQt5.qt5ct

      libreoffice-qt
    ]);
}
