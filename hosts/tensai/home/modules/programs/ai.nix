{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    (import inputs.nixpkgs-unstable {
      system = "x86_64-linux"; # or pkgs.system if available
      config.allowUnfree = true;
    }).lmstudio

    (pkgs.callPackage ../../packages/stability-matrix.nix { })
  ];
}
