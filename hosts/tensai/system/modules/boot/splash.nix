{ pkgs, ... }:
{
  boot = {
    consoleLogLevel = 3;

    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"
    ];

    plymouth.enable = true;
    # plymouth.logo = ../../../../../splash.png;
    plymouth.font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
  };
}
