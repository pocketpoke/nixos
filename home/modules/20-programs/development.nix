{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];

  programs.git = {
    enable = true;

    userName = "pocketpoke";
    userEmail = "191191762+pocketpoke@users.noreply.github.com";
    extraConfig.credential.helper = "store";
  };

  programs.vscode = {
    enable = true;

    profiles.default.extensions =
      with pkgs.vscode-extensions;
      [
      ]
      ++ (with pkgs; [
        vscode-extensions.continue.continue
        vscode-extensions.ms-python.black-formatter
        vscode-extensions.ms-python.vscode-pylance
        jnoortheen.nix-ide
        nefrob.vscode-just-syntax
        ms-python.python
        ms-python.pylint
        arrterian.nix-env-selector
      ]);

    mutableExtensionsDir = false;

    profiles.default.userSettings = {
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

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

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
}
