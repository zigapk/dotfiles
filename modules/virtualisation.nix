{ lib, ... }:
{
  # Install docker but don't run it by default (use socket-activation)
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  systemd.services.docker.wantedBy = lib.mkForce [ ];
}
