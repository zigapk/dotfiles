{ ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.initrd.compressor = "zstd";
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.tpm2.enable = true;

  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%";
}
