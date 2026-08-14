{ inputs, pkgs, ... }:
let
  hermes = inputs.hermes-agent.packages.${pkgs.stdenv.hostPlatform.system}.default;
  cuaDriver = inputs.cua-driver-fork.packages.${pkgs.stdenv.hostPlatform.system}.default;
  cuaKwinBridge = inputs.cua-driver-fork.packages.${pkgs.stdenv.hostPlatform.system}.kwin-helper-bridge;
  cuaKwinHelper = inputs.cua-driver-fork.packages.${pkgs.stdenv.hostPlatform.system}.kwin-helper;
  cuaKwinHelperRoot = "${cuaKwinHelper}/share/kwin/scripts/cua-kwin-helper";
  qdbus = "${pkgs.kdePackages.qttools}/bin/qdbus";
  kwriteconfig = "${pkgs.kdePackages.kconfig}/bin/kwriteconfig6";
  kpackagetool = "${pkgs.kdePackages.kpackage}/bin/kpackagetool6";
  cuaKwinHelperLoader = pkgs.writeShellScript "cua-kwin-helper-loader" ''
    set -eu
    if ! ${kpackagetool} --type KWin/Script --upgrade "${cuaKwinHelperRoot}" >/dev/null 2>&1; then
      ${kpackagetool} --type KWin/Script --install "${cuaKwinHelperRoot}"
    fi
    ${kwriteconfig} --file kwinrc --group Plugins --key cua-kwin-helperEnabled true
    ${qdbus} org.kde.KWin /KWin reconfigure
    loaded="$(${qdbus} org.kde.KWin /Scripting isScriptLoaded cua-kwin-helper 2>/dev/null || true)"
    case "$loaded" in
      true|1) ;;
      *) echo "cua-kwin-helper failed to load" >&2; exit 1 ;;
    esac
  '';
  hermesHome = "/home/user/.hermes";
in
{
  home.sessionVariables = {
    HERMES_CUA_DRIVER_CMD = "${cuaDriver}/bin/cua-driver";
    CUA_DRIVER_RS_ENABLE_WAYLAND = "1";
  };

  systemd.user.services.cua-kwin-helper-bridge = {
    Unit = {
      Description = "KWin bridge for cua-driver target input";
      After = [ "graphical-session.target" ];
      Before = [ "cua-kwin-helper.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${cuaKwinBridge}/bin/kwin-helper-bridge";
      Environment = [
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
        "CUA_KWIN_HELPER_CONFIG=kwinrc"
        "CUA_KWIN_HELPER_GROUP=Script-cua-kwin-helper"
      ];
      Restart = "on-failure";
      RestartSec = 2;
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.cua-kwin-helper = {
    Unit = {
      Description = "Load the KWin helper used by cua-driver";
      Requires = [ "cua-kwin-helper-bridge.service" ];
      After = [ "graphical-session.target" "cua-kwin-helper-bridge.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = cuaKwinHelperLoader;
      RemainAfterExit = true;
      Environment = [ "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus" ];
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.hermes-gateway = {
    Unit = {
      Description = "Hermes Agent Gateway - Messaging Platform Integration";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.steam-run}/bin/steam-run ${hermes}/bin/hermes gateway run --replace";
      WorkingDirectory = hermesHome;
      Environment = [
        "HERMES_HOME=${hermesHome}"
        "PYTHONPATH=${hermesHome}/.local/share/hermes-hindsight"
        "HERMES_CUA_DRIVER_CMD=${cuaDriver}/bin/cua-driver"
        "CUA_DRIVER_RS_ENABLE_WAYLAND=1"
        "LD_PRELOAD=/nix/store/0iv8glcslgfcgn371lbjr5jjw5a6cqir-gcc-15.3.0-lib/lib/libstdc++.so.6"
      ];
      Restart = "on-failure";
      RestartSec = 30;
      RestartForceExitStatus = 75;
      KillMode = "mixed";
      KillSignal = "SIGTERM";
      TimeoutStopSec = 60;
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.services.hermes-dashboard = {
    Unit = {
      Description = "Hermes Agent Built-in Web Dashboard";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.steam-run}/bin/steam-run ${hermes}/bin/hermes dashboard --host 100.78.105.116 --port 9119 --no-open";
      WorkingDirectory = hermesHome;
      Environment = [
        "HERMES_HOME=${hermesHome}"
        "PYTHONPATH=${hermesHome}/.local/share/hermes-hindsight"
        "HERMES_CUA_DRIVER_CMD=${cuaDriver}/bin/cua-driver"
        "CUA_DRIVER_RS_ENABLE_WAYLAND=1"
        "LD_PRELOAD=/nix/store/0iv8glcslgfcgn371lbjr5jjw5a6cqir-gcc-15.3.0-lib/lib/libstdc++.so.6"
      ];
      EnvironmentFile = "-${hermesHome}/dashboard.env";
      Restart = "on-failure";
      RestartSec = 5;
      KillSignal = "SIGTERM";
      TimeoutStopSec = 30;
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "default.target" ];
  };

  # Hindsight API using the system PostgreSQL service. The currently
  # installed Hindsight runtime is exposed through Hermes' writable runtime
  # directory; the service and its runtime configuration remain declarative.
  systemd.user.services.hindsight-api = {
    Unit = {
      Description = "Hindsight Memory API";
      After = [ "postgresql.service" ];
      Wants = [ "postgresql.service" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.steam-run}/bin/steam-run ${pkgs.python312}/bin/python -m hindsight_api.main --host 127.0.0.1 --port 8888 --no-access-log";
      WorkingDirectory = hermesHome;
      Environment = [
        "HERMES_HOME=${hermesHome}"
        "PYTHONPATH=${hermesHome}/.local/share/hermes-hindsight"
        "HERMES_CUA_DRIVER_CMD=${cuaDriver}/bin/cua-driver"
        "CUA_DRIVER_RS_ENABLE_WAYLAND=1"
        "LD_PRELOAD=/nix/store/0iv8glcslgfcgn371lbjr5jjw5a6cqir-gcc-15.3.0-lib/lib/libstdc++.so.6"
        "HINDSIGHT_API_DATABASE_URL=postgresql://user@/hindsight?host=/run/postgresql"
        "HINDSIGHT_API_HOST=127.0.0.1"
        "HINDSIGHT_API_PORT=8888"
      ];
      EnvironmentFile = "-/home/user/.hindsight/profiles/hermes.env";
      Restart = "on-failure";
      RestartSec = 10;
      KillSignal = "SIGTERM";
      TimeoutStopSec = 30;
      StandardOutput = "journal";
      StandardError = "journal";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
