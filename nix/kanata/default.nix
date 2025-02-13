_: {
  services.kanata = {
    enable = true;
    keyboards.all.config = builtins.readFile ./kanata.kbd;
  };
}
