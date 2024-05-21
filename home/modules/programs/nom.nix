{pkgs, ...}: {
  home.packages = with pkgs; [
    nom
  ];
}