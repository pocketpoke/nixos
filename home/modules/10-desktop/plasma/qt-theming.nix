{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
