{
  services.openssh = {
    enable = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
      UseDns = true;
      X11Forwarding = false;
    };
  };
}
