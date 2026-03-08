{ ... }:

{
  programs.plasma = {
    enable = true;
    shortcuts = {
      "services/org.flameshot.Flameshot.desktop".Capture = "Meta+Shift+S";
      kwin."KZones: Snap all windows" = [ ];
      "services/org.kde.krunner.desktop"._launch = [
        "Meta+Space"
        "Search"
        "Alt+F2"
      ];

      # Krohnkite
      kwin.KrohnkiteBTreeLayout = [ ];
      kwin.KrohnkiteColumnsLayout = [ ];
      kwin.KrohnkiteDecrease = [ ];
      kwin.KrohnkiteFloatAll = "Meta+Shift+F";
      kwin.KrohnkiteFloatingLayout = [ ];
      kwin.KrohnkiteFocusDown = [ ];
      kwin.KrohnkiteFocusLeft = [ ];
      kwin.KrohnkiteFocusNext = [ ];
      kwin.KrohnkiteFocusPrev = "Meta+\\";
      kwin.KrohnkiteFocusRight = [ ];
      kwin.KrohnkiteFocusUp = [ ];
      kwin.KrohnkiteGrowHeight = "Meta+Ctrl+PgDown";
      kwin.KrohnkiteIncrease = "Meta+I";
      kwin.KrohnkiteMonocleLayout = "Meta+M";
      kwin.KrohnkiteNextLayout = "Meta+\\\\,none";
      kwin.KrohnkitePreviousLayout = "Meta+|";
      kwin.KrohnkiteQuarterLayout = [ ];
      kwin.KrohnkiteRotate = [ ];
      kwin.KrohnkiteRotatePart = [ ];
      kwin.KrohnkiteSetMaster = "Meta+Return";
      kwin.KrohnkiteShiftDown = "Meta+Down";
      kwin.KrohnkiteShiftLeft = "Meta+Left";
      kwin.KrohnkiteShiftRight = "Meta+Right";
      kwin.KrohnkiteShiftUp = "Meta+Up";
      kwin.KrohnkiteShrinkHeight = "Meta+Ctrl+PgUp";
      kwin.KrohnkiteShrinkWidth = "Meta+Shift+PgUp";
      kwin.KrohnkiteSpiralLayout = [ ];
      kwin.KrohnkiteSpreadLayout = [ ];
      kwin.KrohnkiteStackedLayout = [ ];
      kwin.KrohnkiteStairLayout = [ ];
      kwin.KrohnkiteTileLayout = [ ];
      kwin.KrohnkiteToggleFloat = "Meta+F";
      kwin.KrohnkiteTreeColumnLayout = [ ];
      kwin.KrohnkitegrowWidth = "Meta+Shift+PgDown";
      kwin.KrohnkitetoggleDock = [ ];

      kwin.Overview = [
        "Meta+A"
        "Meta+W"
      ];
      kwin."Switch to Desktop 1" = [
        "Ctrl+F1"
        "Meta+!"
      ];
      kwin."Switch to Desktop 2" = [
        "Ctrl+F2"
        "Meta+@"
      ];
      kwin."Switch to Desktop 3" = [
        "Ctrl+F3"
        "Meta+#"
      ];
      kwin."Switch to Desktop 4" = [
        "Ctrl+F4"
        "Meta+$"
      ];
      kwin."Window Close" = [
        "Meta+C"
        "Alt+F4"
      ];

      # Disable defaults for tiling compatability
      kwin."Window Maximize" = [ ];
      kwin."Window Minimize" = [ ];
      kwin."Window Quick Tile Bottom" = [ ];
      kwin."Window Quick Tile Left" = [ ];
      kwin."Window Quick Tile Right" = [ ];
      kwin."Window Quick Tile Top" = [ ];
      plasmashell."next activity" = [ ];
    };
    configFile = {
      # Theme
      plasmarc.Theme.name = "Qogir-dark";
      kdeglobals.WM.activeBackground = "40,42,51";
      kdeglobals.WM.activeBlend = "40,42,51";
      kdeglobals.WM.activeForeground = "177,178,183";
      kdeglobals.WM.inactiveBackground = "40,42,51";
      kdeglobals.WM.inactiveBlend = "47,52,63";
      kdeglobals.WM.inactiveForeground = "102,106,115";
      ksplashrc.KSplash.Engine = "none";
      ksplashrc.KSplash.Theme = "None";
      kcminputrc.Mouse.cursorTheme = "Qogir-Dark";

      # Desktops
      kwinrc.Desktops.Id_1 = "4c3d8227-047d-4de2-987c-728a1a33047e";
      kwinrc.Desktops.Id_2 = "19b0ce7a-7a6a-4aff-a629-2ea22c0e92a3";
      kwinrc.Desktops.Id_3 = "4d282a8e-36cc-41b2-895c-189c0b41c83f";
      kwinrc.Desktops.Id_4 = "e30f8fa7-b4a3-4795-b18a-ac1ebfd03a02";
      kwinrc.Desktops.Name_1 = "Main";
      kwinrc.Desktops.Name_2 = "Code";
      kwinrc.Desktops.Name_3 = "VODs";
      kwinrc.Desktops.Name_4 = "Social";
      kwinrc.Desktops.Number = 4;
      kwinrc.Desktops.Rows = 1;

      # Flameshot Wayland Window Rule Fix
      kwinrulesrc.General.count = 1;
      kwinrulesrc.General.rules = "35eccb80-3c37-402d-9432-1ad91723ab13";
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".Description = "Flameshot Wayland";
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".above = true;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".aboverule = 2;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".fullscreenrule = 2;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".ignoregeometry = true;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".ignoregeometryrule = 2;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".position = "0,0";
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".positionrule = 2;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".size = "5760,1080";
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".sizerule = 2;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".types = 1;
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".wmclass = "flameshot";
      kwinrulesrc."35eccb80-3c37-402d-9432-1ad91723ab13".wmclassmatch = 1;

      # Tiling
      kwinrc.Plugins.krohnkiteEnabled = true;
      kwinrc.Script-krohnkite.noTileBorder = true;
      kwinrc.Script-krohnkite.screenGapBetween = 8;
      kwinrc.Script-krohnkite.screenGapBottom = 8;
      kwinrc.Script-krohnkite.screenGapLeft = 8;
      kwinrc.Script-krohnkite.screenGapRight = 8;
      kwinrc.Script-krohnkite.screenGapTop = 8;

      # Geometry Change Effect
      kwinrc.Plugins.kwin4_effect_geometry_changeEnabled = true;

      krunnerrc.General.FreeFloating = true;
      kscreenlockerrc.Daemon.LockGrace = 0;
      kwalletrc.Wallet."First Use" = false;
      kwinrc.Compositing.AllowBlockCompositing = false;
      kwinrc.Compositing.AllowTearing = false;
      kwinrc.Compositing.GLCore = false;
      kwinrc.Compositing.GLPreferBufferSwap = "e";
      kwinrc.Compositing.UnredirectFullscreen = false;
      kwinrc.Compositing.WindowsBlockCompositing = false;
      kwinrc.Xwayland.Scale = 1;
      kwinrc.Plugins.kzonesEnabled = false;
      kwinrc.Script-kzones.layoutsJson = ''
        [
          {
            "name": "Quadrants",
            "padding": 0,
            "zones": [
              {
                "x": 0,
                "y": 0,
                "height": 50,
                "width": 50
              },
              {
                "x": 0,
                "y": 50,
                "height": 50,
                "width": 50
              },
              {
                "x": 50,
                "y": 50,
                "height": 50,
                "width": 50
              },
              {
                "x": 50,
                "y": 0,
                "height": 50,
                "width": 50
              }
            ]
          },
          {
            "name": "Bleh",
            "padding": 0,
            "zones": [
              {
                "x": 25,
                "y": 0,
                "height": 100,
                "width": 75
              },
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 25
              }
            ]
          },
          {
            "name": "Half and Two Vertical Quarters (Mirrored)",
            "padding": 0,
            "zones": [
              {
                "x": 50,
                "y": 0,
                "height": 100,
                "width": 50
              },
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 25
              },
              {
                "x": 25,
                "y": 0,
                "height": 100,
                "width": 25
              }
            ]
          },
          {
            "name": "Half and Two Quarters (Mirrored)",
            "padding": 0,
            "zones": [
              {
                "x": 50,
                "y": 0,
                "height": 100,
                "width": 50
              },
              {
                "x": 0,
                "y": 0,
                "height": 50,
                "width": 50
              },
              {
                "x": 0,
                "y": 50,
                "height": 50,
                "width": 50
              }
            ]
          },
          {
            "name": "Priority Columns",
            "padding": 0,
            "zones": [
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 25
              },
              {
                "x": 25,
                "y": 0,
                "height": 100,
                "width": 50
              },
              {
                "x": 75,
                "y": 0,
                "height": 100,
                "width": 25
              }
            ]
          },
          {
            "name": "Half and Two Quarters",
            "padding": 0,
            "zones": [
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 50
              },
              {
                "x": 50,
                "y": 0,
                "height": 50,
                "width": 50
              },
              {
                "x": 50,
                "y": 50,
                "height": 50,
                "width": 50
              }
            ]
          },
          {
            "name": "Half and Two Vertical Quarters",
            "padding": 0,
            "zones": [
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 50
              },
              {
                "x": 50,
                "y": 0,
                "height": 100,
                "width": 25
              },
              {
                "x": 75,
                "y": 0,
                "height": 100,
                "width": 25
              }
            ]
          },
          {
            "name": "Bleh ( Mirrored )",
            "padding": 0,
            "zones": [
              {
                "x": 75,
                "y": 0,
                "height": 100,
                "width": 25
              },
              {
                "x": 0,
                "y": 0,
                "height": 100,
                "width": 75
              }
            ]
          },
          {
            "name": "Quadrants (Mirrored)",
            "padding": 0,
            "zones": [
              {
                "x": 0,
                "y": 0,
                "height": 50,
                "width": 50
              },
              {
                "x": 0,
                "y": 50,
                "height": 50,
                "width": 50
              },
              {
                "x": 50,
                "y": 50,
                "height": 50,
                "width": 50
              },
              {
                "x": 50,
                "y": 0,
                "height": 50,
                "width": 50
              }
            ]
          }
        ]
      '';
    };
  };
}
