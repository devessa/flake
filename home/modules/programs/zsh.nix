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

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      LC_ALL = "en_US.UTF-8";
    };

    envExtra = ''
      # Set fzf options
      export FZF_DEFAULT_OPTS=" \
      --multi \
      --cycle \
      --reverse \
      --bind='ctrl-space:toggle,pgup:preview-up,pgdn:preview-down' \
      --ansi \
      --prompt ' ' \
      --pointer '' \
      --marker ''
      "
    '';

    completionInit = ''
      zmodload zsh/complist
      autoload -U compinit
      zstyle ':completion:*' menu select
      zstyle ':completion::complete:*' gain-privileges 1
      compinit
      _comp_options+=(globdots)
    '';

    initExtra = ''
      # Set options
      while read -r option; do
        setopt $option
      done <<-EOF
      ALWAYS_TO_END
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      APPEND_HISTORY
      ALWAYS_TO_END
      COMPLETE_IN_WORD
      EXTENDED_GLOB
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
      HIST_FIND_NO_DUPS
      HIST_IGNORE_ALL_DUPS
      HIST_IGNORE_DUPS
      HIST_SAVE_NO_DUPS
      INC_APPEND_HISTORY
      INTERACTIVE_COMMENTS
      MENU_COMPLETE
      NO_BEEP
      NOTIFY
      PATH_DIRS
      PUSHD_IGNORE_DUPS
      PUSHD_SILENT
      SHARE_HISTORY
      EOF

      # Unset options
      while read -r option; do
        unsetopt $option
      done <<-EOF
      CASE_GLOB
      CORRECT
      EQUALS
      FLOWCONTROL
      NOMATCH
      EOF

      # Vi mode key bindings
      bindkey -v
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey "^A" vi-beginning-of-line
      bindkey "^E" vi-end-of-line

      export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
      export GPG_TTY=$(tty)
    '';

    shellAliases = {
      run = "nix-shell -p";
      ns = "nix-shell";
      nd = "nix develop";
      g = "git";
      gs = "git st";

      src = "cd $HOME/src";
      sv0 = "ssh -l root proxmox";
      nmcs = "ssh -l kd nmcs";

      rm = "rm -rf";
      cp = "cp -ri";
      mkdir = "mkdir -p";
      free = "free -m";
      j = "just";
      ed = "code";

      l = "eza -al --no-time --group-directories-first";
      ls = "eza -al --no-time --group-directories-first";
      la = "eza -a";
      ll = "eza -l --no-time --group-directories-first";
      lt = "eza -aT --no-time --group-directories-first";

      cat = "bat --theme gruvbox-dark --style numbers,changes --color=always --tabs=2 --wrap=never";
      diff = lib.getExe pkgs.delta;
      rg = lib.getExe pkgs.ripgrep;
      top = "btm";
      c = "clear";
      mkx = "${pkgs.writeShellScriptBin "mkscript" ''
        touch "$@"
        chmod +x "$@"
      ''}/bin/mkscript";
      glg = "git lg";
      ghr = "gh repo";
      serve = "${lib.getExe pkgs.python3} -m http.server";
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
        {name = "chisui/zsh-nix-shell";}
        {name = "jeffreytse/zsh-vi-mode";}
      ];
    };
  };
}
