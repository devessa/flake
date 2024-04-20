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
      --prompt '$ ' \
      --pointer '~' \
      --marker ' >'
      "
    '';

    completionInit = ''
      # Load Zsh modules
      zmodload zsh/zle
      zmodload zsh/zpty
      zmodload zsh/complist

      # Initialize colors
      autoload -Uz colors
      colors

      # Initialize completion system
      autoload -U compinit
      compinit
      _comp_options+=(globdots)

      # Load edit-command-line for ZLE
      autoload -Uz edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line

      # General completion behavior
      zstyle ':completion:*' completer _extensions _complete _approximate

      # Use cache
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

      # Complete the alias
      zstyle ':completion:*' complete true

      # Autocomplete options
      zstyle ':completion:*' complete-options true

      # Completion matching control
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*' keep-prefix true

      # Group matches and describe
      zstyle ':completion:*' menu select
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'

      # Colors
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      # Directories
      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
      zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
      zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
      zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' squeeze-slashes true

      # Sort
      zstyle ':completion:*' sort false
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:eza' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:files' sort false

      # fzf-tab
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview $realpath'
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
      zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
      zstyle ':fzf-tab:*' fzf-command fzf
      zstyle ':fzf-tab:*' fzf-pad 4
      zstyle ':fzf-tab:*' fzf-min-height 100
      zstyle ':fzf-tab:*' switch-group ',' '.'
    '';

    initExtra = ''
      # Set options
      while read -r option; do
        setopt $option
      done <<-EOF
      ALWAYS_TO_END
      AUTO_CD
      AUTO_LIST
      AUTO_MENU
      AUTO_PARAM_SLASH
      AUTO_PUSHD
      APPEND_HISTORY
      ALWAYS_TO_END
      CDABLE_VARS
      COMPLETE_IN_WORD
      EXTENDED_GLOB
      EXTENDED_HISTORY
      HIST_EXPIRE_DUPS_FIRST
      HIST_FIND_NO_DUPS
      HIST_IGNORE_ALL_DUPS
      HIST_IGNORE_DUPS
      HIST_IGNORE_SPACE
      HIST_REDUCE_BLANKS
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
      run = "nix-shell --command zsh -p";
      ns = "nix-shell --command zsh";
      nd = "nix develop --command zsh";
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
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "wfxr/forgit";}
        {name = "chisui/zsh-nix-shell";}
        {name = "jeffreytse/zsh-vi-mode";}
      ];
    };
  };
}
