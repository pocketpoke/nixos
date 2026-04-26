{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vast-cli = {
      url = "github:dialohq/vast-cli.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hytale-launcher.url = "github:pocketpoke/hytale-launcher-nix";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    mistral-vibe.url = "github:mistralai/mistral-vibe";
    stream-organizer.url = "github:pocketpoke/StreamOrganizer/dev";
    twitchdownloadercli.url = "github:pocketpoke/TwitchDownloaderCLI-Nix-Flake";
    claude-code.url = "github:sadjow/claude-code-nix";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    {
      nixosConfigurations.tensai = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # ── Hardware Configuration ───────────────────────────────
          (
            {
              config,
              lib,
              pkgs,
              modulesPath,
              ...
            }:
            {
              imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

              boot.initrd.availableKernelModules = [
                "xhci_pci"
                "ahci"
                "nvme"
                "usb_storage"
                "usbhid"
                "sd_mod"
              ];
              boot.initrd.kernelModules = [ ];
              boot.kernelModules = [ ];
              boot.extraModulePackages = [ ];

              fileSystems."/" = {
                device = "/dev/disk/by-uuid/a0f610f8-622e-4a29-8e33-da53c829fb6f";
                fsType = "ext4";
              };

              boot.initrd.luks.devices."luks-48b3a7ac-4e4f-4eb9-9536-8ee30f142d46".device =
                "/dev/disk/by-uuid/48b3a7ac-4e4f-4eb9-9536-8ee30f142d46";

              fileSystems."/boot" = {
                device = "/dev/disk/by-uuid/9709-9861";
                fsType = "vfat";
                options = [
                  "fmask=0077"
                  "dmask=0077"
                ];
              };

              swapDevices = [
                { device = "/dev/disk/by-uuid/439218b4-55dd-4f2a-88d7-6c9e3c945fcc"; }
              ];

              networking.useDHCP = lib.mkDefault true;
              nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
              hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
            }
          )

          # ── System Configuration ──────────────────────────────────
          (
            { config, pkgs, ... }:
            {
              networking.hostName = "tensai";
              system.stateVersion = "25.05";

              boot = {
                loader = {
                  systemd-boot.enable = true;
                  efi.canTouchEfiVariables = true;
                };

                initrd = {
                  luks.devices = {
                    "luks-3c276288-e916-4ccc-9fa4-4ad1c3d60146".device =
                      "/dev/disk/by-uuid/3c276288-e916-4ccc-9fa4-4ad1c3d60146";
                    "storage" = {
                      device = "/dev/disk/by-uuid/03872fe3-cfe6-4965-a4eb-fe64287da8f5";
                      allowDiscards = true;
                    };
                  };
                  verbose = false;
                  systemd.enable = true;
                };

                consoleLogLevel = 3;
                kernelParams = [
                  "quiet"
                  "splash"
                  "intremap=on"
                  "rd.systemd.show_status=auto"
                  "udev.log_priority=3"
                ];

                plymouth.enable = true;
                plymouth.font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";

                swraid.enable = true;
                swraid.mdadmConf = ''
                  ARRAY /dev/md127 metadata=1.2 UUID=2b0845aa:fb6bb2ba:24a3d265:15bec583
                  MAILADDR mdadm@snowshiba.com
                '';

                supportedFilesystems = [ "cifs" ];
                kernelModules = [ "kvm-amd" ];
              };

              fileSystems."/mnt/storage" = {
                device = "/dev/mapper/storage";
                fsType = "ext4";
                neededForBoot = false;
              };

              fileSystems."/home/user/Videos/PowerEdge VODs" = {
                device = "//poweredge/vods";
                fsType = "cifs";
                options = [
                  "credentials=/etc/nixos/smb-creds"
                  "uid=1000"
                  "gid=100"
                  "file_mode=0664"
                  "dir_mode=0775"
                  "vers=3.0"
                  "cache=strict"
                  "x-systemd.automount"
                  "noauto"
                  "x-systemd.idle-timeout=600"
                  "x-systemd.device-timeout=5"
                  "x-systemd.mount-timeout=5"
                  "_netdev"
                  "x-systemd.requires=tailscaled.service"
                  "x-systemd.after=tailscaled.service"
                ];
              };

              time.timeZone = "America/New_York";

              i18n.defaultLocale = "en_US.UTF-8";
              i18n.extraLocaleSettings = {
                LC_ADDRESS = "en_US.UTF-8";
                LC_IDENTIFICATION = "en_US.UTF-8";
                LC_MEASUREMENT = "en_US.UTF-8";
                LC_MONETARY = "en_US.UTF-8";
                LC_NAME = "en_US.UTF-8";
                LC_NUMERIC = "en_US.UTF-8";
                LC_PAPER = "en_US.UTF-8";
                LC_TELEPHONE = "en_US.UTF-8";
                LC_TIME = "en_US.UTF-8";
              };

              nix = {
                gc = {
                  automatic = true;
                  dates = "weekly";
                  options = "--delete-older-than 14d";
                };
                optimise.automatic = true;
                settings = {
                  auto-optimise-store = true;
                  experimental-features = [
                    "nix-command"
                    "flakes"
                  ];
                  substituters = [ "https://claude-code.cachix.org" ];
                  trusted-public-keys = [
                    "claude-code.cachix.org-1:YeXf2aNu7UTX8Vwrze0za1WEDS+4DuI2kVeWEE4fsRk="
                  ];
                };
              };

              nixpkgs.config.allowUnfree = true;

              fonts = {
                enableDefaultPackages = true;
                packages = with pkgs; [
                  noto-fonts
                  noto-fonts-cjk-sans
                ];
                fontconfig = {
                  defaultFonts = {
                    serif = [
                      "Noto Serif"
                      "Noto Serif CJK JP"
                    ];
                    sansSerif = [
                      "Noto Sans"
                      "Noto Sans CJK JP"
                    ];
                    monospace = [
                      "JetBrainsMono Nerd Font"
                      "Noto Sans Mono CJK JP"
                    ];
                    emoji = [ "Noto Color Emoji" ];
                  };
                  antialias = true;
                  hinting.enable = true;
                  hinting.style = "slight";
                };
              };

              services.desktopManager.plasma6.enable = true;
              services.displayManager.sddm.enable = true;
              services.xserver.xkb = {
                layout = "us";
                variant = "";
              };

              services.pulseaudio.enable = false;
              security.rtkit.enable = true;
              services.pipewire = {
                enable = true;
                alsa.enable = true;
                alsa.support32Bit = true;
                pulse.enable = true;
              };

              services.xserver.enable = true;
              services.xserver.videoDrivers = [ "nvidia" ];
              hardware.graphics.enable = true;
              hardware.nvidia = {
                modesetting.enable = true;
                powerManagement.enable = false;
                open = false;
                nvidiaSettings = true;
                package = config.boot.kernelPackages.nvidiaPackages.production;
              };
              environment.variables.CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";

              networking.networkmanager.enable = true;
              hardware.bluetooth.enable = true;
              hardware.bluetooth.powerOnBoot = true;

              virtualisation.docker.enable = true;

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

              programs.steam = {
                enable = true;
                extraCompatPackages = with pkgs; [ proton-ge-bin ];
              };

              services.syncthing = {
                enable = true;
                user = "user";
                dataDir = "/home/user";
                configDir = "/home/user/.config/syncthing";
                openDefaultPorts = true;
              };

              services.tailscale.enable = true;
              services.tailscale.useRoutingFeatures = "client";
              networking.firewall.allowedUDPPorts = [ 41641 ];
              networking.firewall.checkReversePath = "loose";

              programs.virt-manager.enable = true;
              users.groups.libvirtd.members = [ "user" ];
              virtualisation.libvirtd.enable = true;
              virtualisation.spiceUSBRedirection.enable = true;

              environment.systemPackages = with pkgs; [
                zsh
                zsh-powerlevel10k
                zsh-autosuggestions
                zsh-syntax-highlighting
                meslo-lgs-nf
              ];

              programs.zsh = {
                enable = true;
                autosuggestions.enable = true;
                syntaxHighlighting.enable = true;
                enableCompletion = true;
                histSize = 10000;
                promptInit = ''
                  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
                  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
                '';
                ohMyZsh.enable = true;
                ohMyZsh.plugins = [
                  "git"
                  "docker"
                ];
                shellAliases = {
                  rebuild = "pushd ~/.config/nixos; sudo nixos-rebuild switch --flake .; popd";
                  update = "pushd ~/.config/nixos; nix flake update; popd";
                };
              };

              users.users.user = {
                isNormalUser = true;
                description = "User";
                extraGroups = [
                  "networkmanager"
                  "wheel"
                  "docker"
                  "libvirtd"
                ];
                shell = pkgs.zsh;
              };
            }
          )

          # ── Home Manager ───────────────────────────────────────────
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.sharedModules = [ sops-nix.homeManagerModules.sops ];

            home-manager.users.user =
              {
                pkgs,
                config,
                lib,
                inputs,
                ...
              }:
              let
                stability-matrix =
                  let
                    pname = "stability-matrix";
                    version = "2.15.6";

                    src = pkgs.fetchurl {
                      url = "https://github.com/LykosAI/StabilityMatrix/releases/download/v${version}/StabilityMatrix-linux-x64.zip";
                      sha256 = "sha256-fzF/g5EXn/FwfrK2F7zdKx/PsdocUhtLYEy4Re+kMu8=";
                    };

                    extractedAppImage = pkgs.stdenvNoCC.mkDerivation {
                      name = "${pname}-${version}-extracted-appimage";
                      inherit src;
                      nativeBuildInputs = [ pkgs.unzip ];
                      dontUnpack = true;
                      installPhase = ''
                        unzip $src
                        mkdir -p $out
                        cp StabilityMatrix.AppImage $out/
                      '';
                    };

                    desktopItems = pkgs.stdenvNoCC.mkDerivation {
                      name = "${pname}-desktop";
                      dontUnpack = true;
                      dontBuild = true;
                      desktopItem = pkgs.makeDesktopItem {
                        name = pname;
                        exec = "stability-matrix %U";
                        icon = "stability-matrix";
                        desktopName = "Stability Matrix";
                        comment = "Multi-Platform Package Manager and Inference UI for Stable Diffusion.";
                        categories = [ "Graphics" ];
                        terminal = false;
                        startupNotify = true;
                      };
                      installPhase = ''
                        mkdir -p $out/share/applications
                        cp $desktopItem/share/applications/*.desktop $out/share/applications/${pname}.desktop
                      '';
                    };
                  in
                  pkgs.appimageTools.wrapType2 {
                    inherit pname version;
                    src = "${extractedAppImage}/StabilityMatrix.AppImage";

                    nativeBuildInputs = [ pkgs.makeWrapper ];

                    extraPkgs =
                      pkgs: with pkgs; [
                        icu
                        libGL
                        libGLU
                        libxcrypt-legacy
                      ];

                    extraInstallCommands = ''
                      install -Dm444 ${desktopItems}/share/applications/${pname}.desktop \
                        $out/share/applications/${pname}.desktop

                      install -Dm444 ${
                        pkgs.fetchurl {
                          url = "https://lykos.ai/smlogo.svg";
                          sha256 = "sha256:0f4hcgzqzp9sqfrjwb4xzipgzmxaq9xzrzmvyfkf3cjsdwn8264g";
                        }
                      } \
                        $out/share/icons/hicolor/scalable/apps/${pname}.svg

                      wrapProgram $out/bin/stability-matrix \
                        --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" \
                        --set NIX_SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
                    '';

                    meta = with pkgs.lib; {
                      description = "Multi-Platform Package Manager and Inference UI for Stable Diffusion";
                      homepage = "https://github.com/LykosAI/StabilityMatrix";
                      license = licenses.agpl3Only;
                      platforms = [ "x86_64-linux" ];
                      mainProgram = "stability-matrix";
                    };
                  };

                patchright = pkgs.python3Packages.buildPythonPackage {
                  pname = "patchright";
                  version = "1.58.0";
                  format = "wheel";
                  src = pkgs.fetchurl {
                    url = "https://files.pythonhosted.org/packages/ea/86/98d8f42d5186b6864144fb25e21da8aa7cffa5b9d1d76752276610b9ea58/patchright-1.58.0-py3-none-manylinux1_x86_64.whl";
                    hash = "sha256-gyvuL+SM+dwHuzsPDQXu6SMgPzSM2YsUwsUV7s4yZzQ=";
                  };
                  propagatedBuildInputs = with pkgs.python3Packages; [
                    greenlet
                    pyee
                    typing-extensions
                  ];
                  doCheck = false;
                  meta = with pkgs.lib; {
                    description = "Patched and undetected version of Playwright";
                    homepage = "https://github.com/Kaliiiiiiiiii-Vinyzu/patchright-python";
                    license = licenses.asl20;
                  };
                };

                twitchlink-desktop = pkgs.stdenvNoCC.mkDerivation {
                  name = "twitchlink";
                  dontUnpack = true;
                  dontBuild = true;
                  desktopItem = pkgs.makeDesktopItem {
                    name = "twitchlink";
                    exec = "twitchlink %U";
                    icon = "twitchlink";
                    desktopName = "TwitchLink";
                    comment = "Twitch Stream, Video & Clip Downloader/Recorder GUI";
                    categories = [ "AudioVideo" ];
                    terminal = false;
                    startupNotify = true;
                  };
                  installPhase = ''
                    mkdir -p $out/share/applications
                    cp $desktopItem/share/applications/*.desktop $out/share/applications/twitchlink.desktop
                  '';
                };

                twitchlink = pkgs.python3Packages.buildPythonApplication rec {
                  pname = "twitchlink";
                  version = "3564e3b";

                  src = pkgs.fetchFromGitHub {
                    owner = "pocketpoke";
                    repo = "TwitchLink";
                    rev = "3564e3b";
                    sha256 = "sha256-BAIZsN9J3p7YlinXCkdR6shteqIqRc9lV33G9cdTG70=";
                  };

                  format = "other";

                  propagatedBuildInputs = with pkgs.python3Packages; [
                    pyqt6
                    pyqt6-webengine
                    selenium
                    patchright
                  ];

                  nativeBuildInputs = [ pkgs.makeWrapper ];

                  buildInputs = with pkgs; [ ffmpeg-full ];

                  dontBuild = true;

                  installPhase = ''
                    runHook preInstall

                    mkdir -p $out/share/twitchlink
                    cp -r . $out/share/twitchlink/
                    chmod +x $out/share/twitchlink/*.py

                    install -Dm444 ${twitchlink-desktop}/share/applications/${pname}.desktop \
                      $out/share/applications/${pname}.desktop

                    install -Dm444 $out/share/twitchlink/resources/icons/icon.svg \
                      $out/share/icons/hicolor/scalable/apps/${pname}.svg

                    mkdir -p $out/bin
                    makeWrapper ${pkgs.python3}/bin/python $out/bin/twitchlink \
                      --add-flags "$out/share/twitchlink/TwitchLink.py" \
                      --prefix PATH : "${pkgs.ffmpeg-full}/bin" \
                      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
                      --set PYTHONPATH "$out/share/twitchlink:${pkgs.python3Packages.makePythonPath propagatedBuildInputs}" \
                      --chdir "$out/share/twitchlink/"

                    runHook postInstall
                  '';

                  postFixup = ''
                    rm $out/share/twitchlink/resources/dependencies/linux/ffmpeg
                    ln -sf ${pkgs.ffmpeg-full}/bin/ffmpeg $out/share/twitchlink/resources/dependencies/linux/ffmpeg
                  '';

                  meta = with pkgs.lib; {
                    description = "Twitch Stream, Video & Clip Downloader/Recorder GUI";
                    homepage = "https://github.com/devhotteok/TwitchLink";
                    license = licenses.mit;
                    mainProgram = "twitchlink";
                    platforms = platforms.linux;
                  };
                };

                unstable-pkgs = import inputs.nixpkgs-unstable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
              in
              {
                home.username = "user";
                home.homeDirectory = "/home/user";
                home.stateVersion = "25.05";

                imports = [
                  inputs.plasma-manager.homeModules.plasma-manager
                  inputs.vast-cli.homeManagerModules.default
                ];

                home.packages =
                  (with pkgs.kdePackages; [
                    kdeconnect-kde
                    kzones
                    kcalc
                    kate
                    qtstyleplugin-kvantum
                    qt6ct
                  ])
                  ++ (with pkgs; [
                    opencode

                    inputs.claude-code.packages.${stdenv.hostPlatform.system}.claude-code
                    inputs.codex-cli-nix.packages.${stdenv.hostPlatform.system}.default
                    inputs.mistral-vibe.packages.${stdenv.hostPlatform.system}.default
                    inputs.antigravity-nix.packages.${stdenv.hostPlatform.system}.default

                    unstable-pkgs.lmstudio

                    stability-matrix

                    brave
                    librewolf
                    mullvad-browser
                    tor-browser

                    chatterino2
                    thunderbird
                    signal-desktop
                    vesktop

                    inputs.affinity-nix.packages.${stdenv.hostPlatform.system}.v3

                    nixd
                    nixfmt-rfc-style
                    nodejs
                    gh
                    python3

                    inputs.hytale-launcher.packages.${stdenv.hostPlatform.system}.hytale-launcher

                    imgbrd-grabber
                    vlc

                    nextcloud-client
                    wget
                    curl

                    btop
                    fastfetch

                    bitwarden-desktop

                    parsec-bin

                    yazi
                    tree

                    ffmpeg

                    yt-dlp
                    twitchlink

                    inputs.twitchdownloadercli.packages.${stdenv.hostPlatform.system}.twitchdownloadercli
                    inputs.stream-organizer.packages.${stdenv.hostPlatform.system}.default

                    pika-backup
                    virt-viewer

                    gsmartcontrol
                    smartmontools

                    syncthingtray

                    libsForQt5.qtstyleplugin-kvantum
                    libsForQt5.qt5ct
                  ]);

                sops = {
                  defaultSopsFile = ./secrets/chatterino2-settings.json;
                  age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
                  secrets.chatterino2-settings = {
                    key = "";
                    format = "json";
                    path =
                      if pkgs.stdenv.hostPlatform.isDarwin then
                        "${config.home.homeDirectory}/Library/Application Support/chatterino/Settings/settings.json"
                      else
                        "${config.home.homeDirectory}/.local/share/chatterino/Settings/settings.json";
                  };
                };

                home.activation.ensureChatterinoDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                  mkdir -p "${builtins.dirOf config.sops.secrets.chatterino2-settings.path}"
                '';

                programs.git = {
                  enable = true;
                  settings = {
                    user.name = "pocketpoke";
                    user.email = "191191762+pocketpoke@users.noreply.github.com";
                    credential.helper = "store";
                  };
                };

                programs.vscode = {
                  enable = true;

                  profiles.default.extensions =
                    with pkgs.vscode-extensions;
                    [ ]
                    ++ (with pkgs; [
                      vscode-extensions.continue.continue
                      vscode-extensions.ms-python.black-formatter
                      vscode-extensions.ms-python.vscode-pylance
                      vscode-extensions.anthropic.claude-code
                      vscode-extensions.ms-azuretools.vscode-containers
                      jnoortheen.nix-ide
                      nefrob.vscode-just-syntax
                      ms-python.python
                      ms-python.pylint
                      arrterian.nix-env-selector
                    ]);

                  mutableExtensionsDir = false;

                  profiles.default.userSettings = {
                    "extensions.autoUpdate" = false;
                    "extensions.autoCheckUpdates" = false;
                    "update.mode" = "none";
                    "update.showReleaseNotes" = false;

                    "pylint.enable" = true;
                    "pylint.args" = [
                      "--disable=missing-module-docstring"
                      "--disable=missing-class-docstring"
                      "--disable=missing-function-docstring"
                      "--disable=C0114,C0115,C0116,C0111"
                    ];

                    "[python]" = {
                      "editor.defaultFormatter" = "ms-python.black-formatter";
                      "editor.formatOnSave" = true;
                    };

                    "python.languageServer" = "Pylance";
                    "python.analysis.typeCheckingMode" = "strict";
                    "python.analysis.autoImportCompletions" = true;
                    "python.analysis.useLibraryCodeForTypes" = true;

                    "telemetry.enableTelemetry" = false;
                    "telemetry.enableCrashReporter" = false;
                    "telemetry.telemetryLevel" = "off";

                    "continue.telemetryEnabled" = false;
                    "continue.enableTabAutocomplete" = true;
                    "continue.enableChat" = true;

                    "claudeCode.preferredLocation" = "panel";

                    "nix.enableLanguageServer" = true;
                    "nix.serverPath" = "nixd";
                    "nix.hiddenLanguageServerErrors" = [ "textDocument/definition" ];

                    "[nix]" = {
                      "editor.formatOnSave" = true;
                      "editor.defaultFormatter" = "jnoortheen.nix-ide";
                      "editor.quickSuggestions" = {
                        "other" = true;
                        "comments" = false;
                        "strings" = true;
                      };
                      "editor.acceptSuggestionOnEnter" = "on";
                    };

                    "files.associations" = {
                      "Justfile" = "just";
                      "justfile" = "just";
                      "*.just" = "just";
                    };
                  };
                };

                programs.vastai = {
                  enable = true;
                  sshConfig = {
                    enable = true;
                    apiKeyFile = "${config.home.homeDirectory}/.config/vastai/vast_api_key";
                  };
                };

                qt = {
                  enable = true;
                  platformTheme.name = "kvantum";
                  style.name = "kvantum";
                };

                xdg.portal = {
                  enable = true;
                  extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
                  config = {
                    kde.default = [
                      "kde"
                      "gtk"
                      "gnome"
                    ];
                    kde."org.freedesktop.portal.FileChooser" = [ "kde" ];
                    kde."org.freedesktop.portal.OpenURI" = [ "kde" ];
                  };
                };

                xdg.desktopEntries.affinity-v3 = {
                  name = "Affinity";
                  comment = "Professional creative suite for photo editing, vector design, and publishing (v3 unified app)";
                  exec = "affinity-v3 %U";
                  icon = pkgs.fetchurl {
                    url = "https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/affinity-studio-icon.svg";
                    sha256 = "sha256-0ks42ml9zpmg1lf1cj4g3azc3xac7z3fav5bwsd72j7b9hcgl1";
                  };
                  terminal = false;
                  categories = [ "Graphics" ];
                  startupNotify = true;
                };

                xdg.desktopEntries.lm-studio = {
                  name = "LM Studio";
                  comment = "Use the chat UI or local server to experiment and develop with local LLMs.";
                  exec = "lm-studio %U";
                  icon = pkgs.fetchurl {
                    url = "https://lmstudio.ai/_next/static/media/lmstudio-app-logo.11b4d746.webp";
                    sha256 = "10lsvg8a3fbbsh0r11inzcpalf99sjfwqr4b0g4ncpdh6gkvmarv";
                  };
                  terminal = false;
                  categories = [ "Development" ];
                  startupNotify = true;
                };

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

                    kwin."Window Maximize" = [ ];
                    kwin."Window Minimize" = [ ];
                    kwin."Window Quick Tile Bottom" = [ ];
                    kwin."Window Quick Tile Left" = [ ];
                    kwin."Window Quick Tile Right" = [ ];
                    kwin."Window Quick Tile Top" = [ ];
                    plasmashell."next activity" = [ ];
                  };

                  configFile = {
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

                    kwinrc.Plugins.krohnkiteEnabled = true;
                    kwinrc.Script-krohnkite.noTileBorder = true;
                    kwinrc.Script-krohnkite.screenGapBetween = 8;
                    kwinrc.Script-krohnkite.screenGapBottom = 8;
                    kwinrc.Script-krohnkite.screenGapLeft = 8;
                    kwinrc.Script-krohnkite.screenGapRight = 8;
                    kwinrc.Script-krohnkite.screenGapTop = 8;

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
              };
          }
        ];
      };
    };
}
