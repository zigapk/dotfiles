{ pkgs }: {
  enable = true;
  lfs.enable = true;
  userName = "Žiga Patačko Koderman";
  userEmail = "ziga@zerodays.dev";
  #  signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5r1Mt9pLlX7cA8F6ZVZSkrP/k9sPVSrSbeNSnyumrY";
  # signing.signByDefault = true;

  extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "master";
    };
    core = {
      ignorecase = true;
    };
    gpg = {
      ssh.program =
        if pkgs.stdenv.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "${pkgs._1password-gui}/bin/op-ssh-sign";
    };
  };
}
