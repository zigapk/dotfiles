{ inputs, username, ... }:
{
  imports = [ inputs.agenix.nixosModules.default ];

  # Decrypted at activation into /run/agenix/<name> (tmpfs, mode 0400) using the
  # host's ssh_host_ed25519_key. Owned by the user so omp's mcp.json can `cat`
  # them at request time. See secrets/secrets.nix for the recipient list.
  age.secrets = {
    slack-token = {
      file = ../secrets/slack-token.age;
      owner = username;
    };
    agentmail-key = {
      file = ../secrets/agentmail-key.age;
      owner = username;
    };
  };
}
