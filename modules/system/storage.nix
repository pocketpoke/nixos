{ ... }: {
  fileSystems."/mnt/storage" = {
    device = "/dev/mapper/storage";
    fsType = "ext4";
    neededForBoot = false;
  };

  fileSystems."/home/user/Videos/PowerEdge VODs" = {
    device = "//poweredge/vods";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/smb-creds"
      "uid=1000"
      "gid=100"
      "file_mode=0664"
      "dir_mode=0775"
      "vers=3.0"
      "cache=strict"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
      "x-systemd.device-timeout=5"
      "x-systemd.mount-timeout=5"
      "_netdev"
      "x-systemd.requires=tailscaled.service"
      "x-systemd.after=tailscaled.service"
    ];
  };
}
