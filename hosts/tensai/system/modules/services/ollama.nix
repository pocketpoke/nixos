{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      ollama-cuda = prev.ollama-cuda.override {
        cudaArches = [ "61" ];
      };
    })
  ];

  services.ollama = {
    enable = true;
    acceleration = "cuda";
    package = pkgs.ollama-cuda;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_ORIGINS = "*";
    };
  };
}
