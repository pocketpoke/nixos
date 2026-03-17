{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.mistral-vibe.packages.${pkgs.system}.default
  ];
}
