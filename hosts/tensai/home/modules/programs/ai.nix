{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    opencode

    inputs.claude-code.packages.${stdenv.hostPlatform.system}.claude-code
    inputs.codex-cli-nix.packages.${stdenv.hostPlatform.system}.default
    inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
    inputs.antigravity-nix.packages.${stdenv.hostPlatform.system}.default

    (import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    }).lmstudio

    (pkgs.callPackage ../../packages/stability-matrix.nix { })
  ];
}
