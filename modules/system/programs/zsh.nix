{
  lib,
  pkgs,
  ...
}: {
  environment.pathsToLink = ["/share/zsh"];
  imports = [
    ../../../home/modules/programs/starship.nix
  ];

  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      promptInit = ''
        eval "$(${lib.getExe pkgs.starship} init zsh)"
      '';
    };
  };
}
