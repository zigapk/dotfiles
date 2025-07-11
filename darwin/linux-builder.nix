{ pkgs, ... }: {
  nix.linux-builder = {
    enable = true;
    package = pkgs.darwin.linux-builder-x86_64;
    ephemeral = true;
    maxJobs = 8;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 4 * 1024;
        };
        cores = 4;
      };
    };
  };
}
