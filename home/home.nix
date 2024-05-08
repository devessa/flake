{lib, ...}: {
  home = {
    username = "dev";
    homeDirectory = "/home/dev";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
