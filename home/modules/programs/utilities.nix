{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    wget
    curl

    btop
    fastfetch
    yazi
    tree

    ffmpeg

    yt-dlp
    # (pkgs.callPackage ../../packages/twitchlink.nix { })

    # inputs.twitchdownloadercli.packages.${pkgs.system}.twitchdownloadercli
    # inputs.stream-organizer.packages.${pkgs.system}.default

    bitwarden-desktop
    # pika-backup
    virt-viewer

    # gsmartcontrol
    # smartmontools
  ];
}
