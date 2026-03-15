{ ... }:

{
  boot.swraid.enable = true;
  boot.swraid.mdadmConf = ''
    ARRAY /dev/md127 metadata=1.2 UUID=2b0845aa:fb6bb2ba:24a3d265:15bec583
    MAILADDR mdadm@snowshiba.com
  '';

  fileSystems."/mnt/storage" = {
    device = "/dev/mapper/storage";
    fsType = "ext4";
    neededForBoot = false;
  };
}
