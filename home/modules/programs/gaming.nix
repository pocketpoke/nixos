{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.hytale-launcher
  ];
}
