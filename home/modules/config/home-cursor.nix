{
  config,
  pkgs,
  ...
}: {
  home = {
    pointerCursor = {
      package = pkgs.graphite-cursors;
      name = "Graphite-dark";
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      GTK_THEME = config.gtk.theme.name;
      XCURSOR_SIZE = config.home.pointerCursor.size;
      XCURSOR_THEME = config.home.pointerCursor.name;
    };
  };
}
