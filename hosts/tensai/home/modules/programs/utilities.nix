{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    yazi
    tree

    ffmpeg

    yt-dlp
    (pkgs.callPackage ../../packages/twitchlink.nix { })

    inputs.twitchdownloadercli.packages.${stdenv.hostPlatform.system}.twitchdownloadercli
    inputs.stream-organizer.packages.${stdenv.hostPlatform.system}.default

    pika-backup
    virt-viewer

    gsmartcontrol
    smartmontools
  ];
}
