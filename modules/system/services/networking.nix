{
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };

  programs = {
    nm-applet.enable = true;
  };

  services = {
    gnome.glib-networking.enable = true;
    resolved.enable = true;
  };
}
