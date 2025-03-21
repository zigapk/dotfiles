{ pkgs, ... }: {
  services.sketchybar = {
    enable = true;
    config = builtins.readFile ./sketchybar.sh;
  };
  fonts.packages = [
    pkgs.sketchybar-app-font
  ];
}
