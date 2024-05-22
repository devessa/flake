{lib, ...}: {
  imports = [
    ./dev.nix
    ./desktop.nix
    ./services.nix
    ./etc.nix
  ];

  home = {
    username = "dev";
    homeDirectory = "/home/dev";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  manual = {
    html.enable = true;
    json.enable = false;
    manpages.enable = false;
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}