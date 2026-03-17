{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wget
    curl

    btop
    fastfetch

    bitwarden-desktop
    virt-viewer
  ];
}
