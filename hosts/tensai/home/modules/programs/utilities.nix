{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    yazi
    tree

    ffmpeg

    yt-dlp
    (pkgs.callPackage ../../packages/twitchlink.nix { })

    inputs.twitchdownloadercli.packages.${pkgs.system}.twitchdownloadercli
    inputs.stream-organizer.packages.${pkgs.system}.default

    pika-backup
    virt-viewer

    gsmartcontrol
    smartmontools
  ];
}
