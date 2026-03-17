{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lmstudio

    (pkgs.callPackage ../../packages/stability-matrix.nix { })
  ];
}
