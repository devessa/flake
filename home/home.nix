{lib, ...}: {
  home = {
    username = "kyodev";
    homeDirectory = lib.mkForce "/home/dess";
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
