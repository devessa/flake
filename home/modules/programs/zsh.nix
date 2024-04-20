{
  pkgs,
  lib,
  ...
}: {
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dirHashes = {
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      code = "$HOME/Documents/code";
      dots = "$HOME/Documents/code/yuki";
      pics = "$HOME/Pictures";
      vids = "$HOME/Videos";
    };

    initExtra = ''
      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      export GPG_TTY=$(tty)
    '';

    envExtra = ''
      # Set fzf options
      export FZF_DEFAULT_OPTS=" \
      --multi \
      --cycle \
      --reverse \
      --bind='ctrl-space:toggle,pgup:preview-up,pgdn:preview-down' \
      --ansi \
      --prompt '$ ' \
      --pointer '~' \
      --marker ' >'
      "
    '';

    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zstyle ':completion::complete:*' gain-privileges 1
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)
    '';

    shellAliases = {
      run = "nix-shell --command zsh -p";
      ns = "nix-shell --command zsh";
      nd = "nix develop --command zsh";

      switch = "~/nixos/switch";

      src = "cd $HOME/src";
      nfs = "cd $HOME/nixos";

      sv0 = "ssh -l root proxmox";
      nmcs = "ssh -l kd nmcs";

      rm = "rm -rf";
      cp = "cp -ri";
      mkdir = "mkdir -p";
      free = "free -m";
      j = "just";
      e = "code";

      l = "eza -al --no-time --group-directories-first";
      ls = "eza -al --no-time --group-directories-first";
      la = "eza -a";
      ll = "eza -l --no-time --group-directories-first";
      lt = "eza -aT --no-time --group-directories-first";

      cat = "bat";
      diff = "batdiff";
      rg = "batgrep";
      man = "batman";
      top = "btm";
      c = "clear";
      mkscript = "${pkgs.writeShellScriptBin "mkscript" ''
        touch "$@"
        chmod +x "$@"
      ''}/bin/mkscript";
      glg = "git lg";
      ghr = "gh repo";
      serve = "python3 -m http.server";
    };
    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
    };
    zplug = {
      enable = true;
      plugins = [
        {name = "marlonrichert/zsh-autocomplete";}
        {name = "jeffreytse/zsh-vi-mode";}
        {
          name = "hlissner/zsh-autopair";
          tags = [defer:2];
        }
        {name = "wfxr/forgit";}
        {name = "zsh-users/zsh-autosuggestions";}
      ];
    };
  };
}
