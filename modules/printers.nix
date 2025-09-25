{ pkgs, ... }: {
  services.printing.enable = true;

  # Optionally add drivers for common printers
  services.printing.drivers = with pkgs; [
    gutenprint # generic inkjet driver support
    hplip # HP printers
    splix # Samsung SPL printers
    cups-bjnp # Canon BJNP network protocol
  ];
}
