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

      kwin.KrohnkiteBTreeLayout = [ ];
      kwin.KrohnkiteColumnsLayout = "Meta+Shift+G";
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
      kwin.KrohnkiteQuarterLayout = "Meta+Shift+Q";
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
      kwin.KrohnkiteTileLayout = "Meta+Shift+T";
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

      kwin."Window Maximize" = [ ];
      kwin."Window Minimize" = [ ];
      kwin."Window Quick Tile Bottom" = [ ];
      kwin."Window Quick Tile Left" = [ ];
      kwin."Window Quick Tile Right" = [ ];
      kwin."Window Quick Tile Top" = [ ];
      plasmashell."next activity" = [ ];

      "services/org.kde.konsole.desktop".NewWindow = "Meta+T";
      "services/org.kde.spectacle.desktop"._launch = "Meta+Shift+S";

      kwin."KZones: Activate layout 1" = "Meta+Num+1";
      kwin."KZones: Activate layout 2" = "Meta+Num+2";
      kwin."KZones: Activate layout 3" = "Meta+Num+3";
      kwin."KZones: Activate layout 4" = "Meta+Num+4";
      kwin."KZones: Activate layout 5" = "Meta+Num+5";
      kwin."KZones: Activate layout 6" = "Meta+Num+6";
      kwin."KZones: Activate layout 7" = "Meta+Num+7";
      kwin."KZones: Activate layout 8" = "Meta+Num+8";
      kwin."KZones: Activate layout 9" = "Meta+Num+9";
      kwin."KZones: Cycle layouts" = "Ctrl+Alt+D";
      kwin."KZones: Cycle layouts (reversed)" = "Ctrl+Alt+Shift+D";
      kwin."KZones: Move active window to next zone" = "Ctrl+Alt+Right";
      kwin."KZones: Move active window to previous zone" = "Ctrl+Alt+Left";
      kwin."KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
      kwin."KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
      kwin."KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
      kwin."KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
      kwin."KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
      kwin."KZones: Snap active window" = "Meta+Shift+Space";
      kwin."KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
      kwin."KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
      kwin."KZones: Toggle zone overlay" = "Ctrl+Alt+C";
      kwin."Window to Next Screen" = "Meta+Shift+Right";
      kwin."Window to Previous Screen" = "Meta+Shift+Left";
    };

    configFile = {
      kdeglobals."KFileDialog Settings"."Show hidden files" = true;
      kdeglobals."KFileDialog Settings"."Sort by" = "Date";

      kcminputrc.Mouse.X11LibInputXAccelProfileFlat = true;

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

      # Krohnkite is retained for easy rollback but disabled by default.
      kwinrc.Plugins.krohnkiteEnabled = false;
      kwinrc.Script-krohnkite.noTileBorder = false;
      kwinrc.Script-krohnkite.screenGapBetween = 8;
      kwinrc.Script-krohnkite.screenGapBottom = 8;
      kwinrc.Script-krohnkite.screenGapLeft = 8;
      kwinrc.Script-krohnkite.screenGapRight = 8;
      kwinrc.Script-krohnkite.screenGapTop = 8;

      kwinrc.Plugins.kwin4_effect_geometry_changeEnabled = true;
      kwinrc.Plugins.aeroglassblurEnabled = true;
      kwinrc.Plugins.smodglowEnabled = true;

      smodrc.Windeco.EnableShadow = true;
      smodrc.Windeco.DecorationTheme = "Aero";

      krunnerrc.General.FreeFloating = true;
      kscreenlockerrc.Daemon.LockGrace = 0;
      kwalletrc.Wallet."First Use" = false;
      kwinrc.Compositing.AllowBlockCompositing = false;
      kwinrc.Compositing.AllowTearing = false;
      kwinrc.Compositing.GLCore = false;
      kwinrc.Compositing.GLPreferBufferSwap = "e";
      kwinrc.Compositing.UnredirectFullscreen = false;
      kwinrc.Compositing.WindowsBlockCompositing = false;
      kwinrc.Windows.windowSnapZone = 10;
      kwinrc.Windows.borderSnapZone = 10;
      kwinrc.Windows.centerSnapZone = 0;
      kwinrc.Xwayland.Scale = 1;
      kwinrc.Plugins.kzonesEnabled = false;
      kwinrc.Effect-diminactive.Strength = 90;
      kwinrc.Effect-translucency.Inactive = 90;
      kwinrc.Plugins.minimizeallEnabled = false;
      kwinrc."org.kde.kdecoration2".BorderSize = "Normal";
      kwinrc.Script-krohnkite.ignoreClass = "krunner,yakuake,spectacle,kded5,xwaylandvideobridge,plasmashell,ksplashqml,org.kde.plasmashell,org.kde.polkit-kde-authentication-agent-1,org.kde.kruler,kruler,kwin_wayland,ksmserver-logout-greeter,flameshot";
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

      dolphinrc.MainWindow.MenuBar = "Disabled";
      dolphinrc.IconsMode.PreviewSize = 192;

      spectaclerc.Annotations.blurStrength = "0.6764705882352942";
      spectaclerc.Annotations.freehandStrokeColor = "26,26,30";
      spectaclerc.Annotations.freehandStrokeWidth = 6;
      spectaclerc.Annotations.pixelateStrength = 1;
      spectaclerc.Annotations.rectangleFillColor = "31,29,35";
      spectaclerc.Annotations.rectangleShadow = false;
      spectaclerc.Annotations.rectangleStrokeColor = "252,0,4,0";
      spectaclerc.General.autoSaveImage = true;
      spectaclerc.General.clipboardGroup = "PostScreenshotCopyImage";

      ksmserverrc.General.loginMode = "emptySession";

      kiorc.Confirmations.ConfirmDelete = true;
      kiorc.Confirmations.ConfirmEmptyTrash = true;

      plasmaparc.General.AudioFeedback = false;
      plasmaparc.General.GlobalMute = true;

      kscreenlockerrc."Greeter][Wallpaper][org.kde.image][General".Image =
        "/home/user/Pictures/Wallpapers/Desktops/Henya/April 2026.png";
    };

    workspace = {
      wallpaperSlideShow = {
        path = "/home/user/Pictures/Wallpapers/Desktop/Henya";
        interval = 300;
      };
    };

    panels = [
      {
        location = "top";
        height = 32;
        floating = true;
        hiding = "dodgewindows";
        opacity = "adaptive";
        screen = 0;
        widgets = [
          {
            kickoff = {
              icon = "distributor-logo-nixos";
              showButtonsFor = {
                custom = [
                  "suspend"
                  "hibernate"
                  "reboot"
                  "shutdown"
                ];
              };
            };
          }
          "org.kde.plasma.panelspacer"
          {
            iconTasks = {
              launchers = [
                "preferred://browser"
                "preferred://filemanager"
                "applications:vesktop.desktop"
                "applications:com.chatterino.chatterino.desktop"
                "applications:signal.desktop"
                "applications:thunderbird.desktop"
              ];
            };
          }
          "org.kde.plasma.panelspacer"
          {
            pager = {
              general = {
                showWindowOutlines = false;
                showOnlyCurrentScreen = true;
                displayedText = "desktopName";
                selectingCurrentVirtualDesktop = "showDesktop";
                navigationWrapsAround = true;
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          {
            systemTray = {
              items = {
                extra = [
                  "org.kde.plasma.manage-inputmethod"
                  "org.kde.plasma.devicenotifier"
                  "org.kde.plasma.clipboard"
                  "org.kde.plasma.notifications"
                  "org.kde.plasma.cameraindicator"
                  "org.kde.plasma.networkmanagement"
                  "org.kde.kscreen"
                  "org.kde.plasma.keyboardlayout"
                  "org.kde.plasma.volume"
                  "org.kde.plasma.keyboardindicator"
                  "org.kde.plasma.weather"
                  "org.kde.kdeconnect"
                  "org.kde.plasma.bluetooth"
                ];
              };
            };
          }
          {
            digitalClock = {
              settings = {
                Appearance.fontWeight = 400;
              };
            };
          }
        ];
      }
    ];
  };
}
