{ pkgs, lib, signer }:
# `signer` selects how commits/tags get signed:
#   "op"    → 1Password app's op-ssh-sign (kanta, where the GUI runs).
#   "agent" → default ssh-keygen against $SSH_AUTH_SOCK. On kibla this is the
#             1Password agent forwarded over SSH from kanta, so signing prompts
#             on kanta and FAILS CLOSED if there is no agent / no approval.
let
  sshSign = lib.optionalAttrs (signer == "op") {
    ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
  };
in
{
  enable = true;
  lfs.enable = true;
  signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG5r1Mt9pLlX7cA8F6ZVZSkrP/k9sPVSrSbeNSnyumrY";
  signing.signByDefault = true;

  settings = {
    user = {
      name = "Žiga Patačko Koderman";
      email = "ziga@zerodays.dev";
    };
    pull = {
      rebase = false;
    };
    push = {
      autoSetupRemote = true;
    };
    init = {
      defaultBranch = "master";
    };
    core = {
      ignorecase = true;
    };
    gpg = {
      format = "ssh";
    } // sshSign;
    url = {
      "ssh://git@github.com/" = {
        insteadOf = "https://github.com/";
      };
    };
  };
}
