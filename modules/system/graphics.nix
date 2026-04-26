{ config, pkgs, ... }: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  environment.variables.CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
}
