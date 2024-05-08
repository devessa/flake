{
  environment.pathsToLink = ["/share/zsh"];

  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      promptInit = ''
        PS1='%B%1~%b %(#.#.$): '
      '';
    };
  };
}
