{ pkgs, username, ... }:
{
  # Set zsh as the default for all users
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.enableAllTerminfo = true;

  # Enable sudo without password
  security.sudo.wheelNeedsPassword = false;
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65536";
    }
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "1048576";
    }
  ];

  # Define a user account
  users.users.${username} = {
    isNormalUser = true;
    description = "Žiga Patačko Koderman";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5r1Mt9pLlX7cA8F6ZVZSkrP/k9sPVSrSbeNSnyumrY"
    ];
  };
}
