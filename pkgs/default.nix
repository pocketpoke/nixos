{ inputs, ... }:
{
  nixpkgs.overlays = [
    (
      final: prev:
      let
        hermesPackage = inputs.hermes-agent.packages.${final.stdenv.hostPlatform.system}.default;
        cuaDriver = inputs.cua-driver-fork.packages.${final.stdenv.hostPlatform.system}.default;
      in
      {
        stability-matrix = final.callPackage ./stability-matrix.nix { };
        patchright = final.callPackage ./patchright.nix { };
        twitchlink = final.callPackage ./twitchlink.nix { };
        imgbrd-grabber = final.callPackage ./imgbrd-grabber.nix {
          imgbrd-grabber = prev.imgbrd-grabber;
        };
        hermes-cli = final.writeShellScriptBin "hermes" ''
          export HERMES_HOME="''${HERMES_HOME:-$HOME/.hermes}"
          export PLAYWRIGHT_BROWSERS_PATH=0
          export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
          export NPM_CONFIG_PREFIX="''${NPM_CONFIG_PREFIX:-$HOME/.local}"
          export PATH="$HOME/.local/bin:$PATH"
          # Route every newly launched Hermes CLI session to the pinned
          # personal cua-driver fork; an explicit caller override still wins.
          export HERMES_CUA_DRIVER_CMD="''${HERMES_CUA_DRIVER_CMD:-${cuaDriver}/bin/cua-driver}"
          # The Python package intentionally excludes the Electron workspace.
          # Route the desktop subcommand to the separately packaged Electron
          # artifact instead of making `hermes desktop` look for
          # /nix/store/.../site-packages/apps/desktop.
          if [[ "''${1-}" == "desktop" || "''${1-}" == "gui" ]] \
            && command -v hermes-desktop >/dev/null 2>&1; then
            exec hermes-desktop "''${@:2}"
          fi
          exec ${hermesPackage}/bin/hermes "$@"
        '';
      }
    )
  ];
}
