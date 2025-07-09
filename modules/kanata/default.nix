_: {
  services.kanata = {
    enable = false;
    keyboards.all.config = builtins.readFile ./kanata.kbd;
  };
}
