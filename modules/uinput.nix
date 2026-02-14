{ username, ... }:
{
  # Load uinput kernel module
  boot.kernelModules = [ "uinput" ];

  # Create udev rule for uinput access
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="uinput", MODE="0660"
  '';

  # Create the uinput group
  users.groups.uinput = {};

  # Add user to the uinput group
  users.users.${username} = {
    extraGroups = [ "uinput" ];
  };
}
