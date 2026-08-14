{ config, pkgs, ... }:
{
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
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = false;
    nvidiaPersistenced = false;
    package = config.boot.kernelPackages.nvidiaPackages.dc_570;
  };

  # Allow prebuilt Linux binaries such as cua-driver to run on NixOS.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libX11
      libxcb
      libxkbcommon
      wayland
      mesa
      libxcomposite
      libxcursor
      libxdamage
      libxext
      libxfixes
      libxi
      libxrandr
      libxtst
    ];
  };

  environment.variables.CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
  environment.variables.QSG_RHI_BACKEND = "opengl";
  environment.sessionVariables.CUA_DRIVER_RS_ENABLE_WAYLAND = "1";
}
