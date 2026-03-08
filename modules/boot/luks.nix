{ ... }:

{
  boot.initrd.luks.devices = {
    "luks-3c276288-e916-4ccc-9fa4-4ad1c3d60146".device =
      "/dev/disk/by-uuid/3c276288-e916-4ccc-9fa4-4ad1c3d60146";

    "storage" = {
      device = "/dev/disk/by-uuid/03872fe3-cfe6-4965-a4eb-fe64287da8f5";
      preLVM = false;
      allowDiscards = true;
    };
  };
}
