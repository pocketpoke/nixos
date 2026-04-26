{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      luks.devices = {
        "luks-3c276288-e916-4ccc-9fa4-4ad1c3d60146".device =
          "/dev/disk/by-uuid/3c276288-e916-4ccc-9fa4-4ad1c3d60146";
        "storage" = {
          device = "/dev/disk/by-uuid/03872fe3-cfe6-4965-a4eb-fe64287da8f5";
          allowDiscards = true;
        };
      };
      verbose = false;
      systemd.enable = true;
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "rd.systemd.show_status=auto"
      "udev.log_priority=3"
    ];

    plymouth.enable = true;
    plymouth.font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";

    swraid.enable = true;
    swraid.mdadmConf = ''
      ARRAY /dev/md127 metadata=1.2 UUID=2b0845aa:fb6bb2ba:24a3d265:15bec583
      MAILADDR mdadm@snowshiba.com
    '';

    supportedFilesystems = [ "cifs" ];
    kernelModules = [ "kvm-amd" ];
  };
}
