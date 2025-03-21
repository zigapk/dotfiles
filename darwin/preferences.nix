{ pkgs, ... }:
let
  inputSources = [
    {
      InputSourceKind = "Keyboard Layout";
      "KeyboardLayout ID" = 252;
      "KeyboardLayout Name" = "ABC";
    }
    {
      InputSourceKind = "Keyboard Layout";
      "KeyboardLayout ID" = -66;
      "KeyboardLayout Name" = "Slovenian";
    }
  ];
in
{
  dock = {
    autohide = true;
    persistent-apps = [
      "/Applications/1Password.app"
      "/Applications/Ghostty.app"
      "/Applications/Zen Browser.app"
    ];
    largesize = 70;
    magnification = true;
    mru-spaces = false;
    show-recents = false;
    tilesize = 60;
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
  };
  screensaver = {
    askForPassword = true;
    askForPasswordDelay = 0;
  };
  finder = {
    FXPreferredViewStyle = "clmv";
    _FXSortFoldersFirstOnDesktop = true;
    AppleShowAllExtensions = true;
    FXDefaultSearchScope = "SCcf";
    FXEnableExtensionChangeWarning = false;
    NewWindowTarget = "Home";
    QuitMenuItem = true;
    ShowPathbar = true;
  };
  controlcenter = {
    AirDrop = false;
    BatteryShowPercentage = false;
    Bluetooth = false;
    Display = false;
    FocusModes = false;
    Sound = true;
  };
  hitoolbox.AppleFnUsageType = "Change Input Source";
  loginwindow.GuestEnabled = false;
  NSGlobalDomain = {
    AppleICUForce24HourTime = true;
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
    "com.apple.sound.beep.feedback" = 0;
    AppleKeyboardUIMode = 3;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleTemperatureUnit = "Celsius";
    NSAutomaticSpellingCorrectionEnabled = false;
    NSNavPanelExpandedStateForSaveMode = true;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticInlinePredictionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    _HIHideMenuBar = true;
  };
  screencapture.location = "~/Desktop";
  trackpad.Clicking = true;
  trackpad.TrackpadRightClick = true;
  SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
  CustomUserPreferences = {
    "com.apple.HIToolbox" = {
      AppleCurrentKeyboardLayoutInputSourceID = "com.apple.keylayout.ABC";
      AppleEnabledInputSources = inputSources;
      AppleSelectedInputSources = inputSources;
    };
    "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
    # Turn on app auto-update
    "com.apple.commerce".AutoUpdate = true;
    "com.apple.SoftwareUpdate" = {
      AutomaticCheckEnabled = true;
      # Check for software updates daily, not just once per week
      ScheduleFrequency = 1;
      # Download newly available updates in background
      AutomaticDownload = 1;
      # Install System data files & security updates
      CriticalUpdateInstall = 1;
    };
    "com.apple.symbolichotkeys" = {
      AppleSymbolicHotKeys = {
        "64" = {
          enabled = 0;
          value = {
            parameters = [ 32 49 1048576 ];
            type = "standard";
          };
        };
      };
    };
  };
}
