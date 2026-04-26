{ ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      ollama-cuda = prev.ollama-cuda.override { cudaArches = [ "61" ]; };
      stability-matrix = final.callPackage ./stability-matrix.nix { };
      patchright = final.callPackage ./patchright.nix { };
      twitchlink = final.callPackage ./twitchlink.nix { };
    })
  ];
}
