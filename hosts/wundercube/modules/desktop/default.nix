{ self, lib, ... }:

let
  wallpaperFolder = "/Users/user/Pictures/Wallpapers/Henya";
  changeIntervalMinutes = 15;
in
{
  # System defaults (dock, trackpad, etc.)
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        mru-spaces = false;
        orientation = "bottom";
        show-recents = false;
        persistent-apps = [
          "/System/Applications/Launchpad.app"
          "/Users/user/Applications/Home Manager Apps/Brave Browser.app"
        ];
      };

      trackpad = {
        Clicking = true;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };
    };
  };

  system.activationScripts.setWallpaperSlideshow = lib.stringAfter [ "users" "darwin" ] ''
    echo "Setting desktop slideshow from ${wallpaperFolder} every ${toString changeIntervalMinutes} min"

    /usr/bin/osascript <<EOF || true
    tell application "System Events"
        tell every desktop
            set picture rotation to ${toString changeIntervalMinutes}
            set random order to true
            set picture to POSIX file "${wallpaperFolder}"
        end tell
    end tell
    EOF

    # Fallback defaults write
    defaults write com.apple.systempreferences DSKDesktopPrefPane -dict-add UserFolderPaths -array-add "${wallpaperFolder}"
    defaults write ~/Library/Preferences/com.apple.desktop Background '{default = { Change = "Time"; ChangePath = "${wallpaperFolder}"; ChangeTime = ${toString changeIntervalMinutes}; Random = 1; }; }' || true

    killall Dock cfprefsd SystemUIServer || true
    sleep 2
  '';
}
