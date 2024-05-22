{pkgs, ...}: {
  home.packages = with pkgs; [
    nom
    pinta
    vesktop
    signal-desktop
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [wlrobs];
  };
}