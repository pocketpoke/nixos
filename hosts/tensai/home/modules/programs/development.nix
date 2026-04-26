{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    nodejs
    gh
    python3
  ];

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
      "nix.hiddenLanguageServerErrors" = [
        "textDocument/definition"
      ];

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
