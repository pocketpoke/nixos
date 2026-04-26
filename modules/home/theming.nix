{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config = {
      kde.default = [
        "kde"
        "gtk"
        "gnome"
      ];
      kde."org.freedesktop.portal.FileChooser" = [ "kde" ];
      kde."org.freedesktop.portal.OpenURI" = [ "kde" ];
    };
  };
}
