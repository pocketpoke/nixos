{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # lmstudio

    inputs.mistral-vibe.packages.${pkgs.system}.default

    # (pkgs.callPackage ../../packages/stability-matrix.nix { })
  ];
}
