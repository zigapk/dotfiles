{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      roboto
      nerd-fonts.droid-sans-mono
    ];
  };
}
