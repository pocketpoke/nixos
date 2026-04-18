{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nextcloud-client
    wget
    curl

    btop
    fastfetch

    bitwarden-desktop
    virt-viewer
  ];
}
