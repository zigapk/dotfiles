{ hostname, ... }:
{
  # --- Network-critical config shared by every host. ---
  # This module is the safety anchor: hostname, NetworkManager, DNS, tailscale,
  # openssh and firewall all live here so a role split can never accidentally
  # drop the path that keeps a remote host reachable over the tailnet.

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved";

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale.enable = true;

  # Trust the tailscale interface so services bound on one host are reachable
  # from another by hostname (kibla:5173, kanta:3000, ...) without per-port
  # firewall juggling. `loose` reverse-path keeps tailscale's asymmetric
  # routing from being dropped by the firewall.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";

  networking.firewall.allowedTCPPorts = [
    22
    80
    443
    1883
    3000
    4000
    8000
    8080
    8099
    5678
    5173
  ];
}
