# agenix recipients. Each `.age` file is encrypted to BOTH host keys so either
# machine can decrypt at activation. Regenerate a secret's ciphertext with:
#   op read 'op://<vault>/<item>/<field>' | nix run github:ryantm/agenix -- -e secrets/<name>.age
# (run from the repo root; agenix reads this file for the recipient list).
let
  kanta = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqFBD4O+VOnED73wV5/Z0ua0f0Vf7Q8aW9JUkE525YD";
  kibla = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFopw4B9jHX34cLksL+6HoF2n3hGvj0U/zPL0Pq3mh73";
  all = [ kanta kibla ];
in
{
  "slack-token.age".publicKeys = all;
  "agentmail-key.age".publicKeys = all;
}
