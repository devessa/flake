{
  config,
  pkgs,
  inputs,
  ...
}: {
  home = {
    packages = with pkgs; [bruno just nil alejandra corepack zoxide inputs.nh.packages.x86_64-linux.default];
  };
  programs = {
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;

      font = {
        package = pkgs.nerdfonts;
        name = "IosevkaTerm Nerd Font";
      };

      environment = {
        EDITOR = "code --wait";
        TERM = "xterm-256color";
      };

      settings = {
        window_padding_width = "4";
        shell = "${pkgs.zsh}/bin/zsh";

        background = "#0c0e0f";
        foreground = "#edeff0";
        cursor = "#edeff0";
        cursor_shape = "beam";

        selection_background = "#1f2122";

        color0 = "#232526";
        color8 = "#0c0e0f";
        color1 = "#df5b61";
        color9 = "#e8646a";
        color2 = "#78b892";
        color10 = "#81c19b";
        color3 = "#de8f78";
        color11 = "#e79881";
        color4 = "#6791c9";
        color12 = "#709ad2";
        color5 = "#bc83e3";
        color13 = "#c58cec";
        color6 = "#67afc1";
        color14 = "#70b8ca";
        color7 = "#e4e6e7";
        color15 = "#f2f4f5";
      };
    };
    lf = {
      enable = true;
      commands = {
        dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
        editor-open = ''$$EDITOR $f'';
        mkdir = ''
          ''${{
            printf "Directory Name: "
            read DIR
            mkdir $DIR
          }}
        '';
      };
      keybindings = {
        "\\\"" = "";
        o = "";
        c = "mkdir";
        D = ''$rm -fr "$fx"'';
        "." = "set hidden!";
        "`" = "mark-load";
        "\\'" = "mark-load";
        "<enter>" = "open";
        do = "dragon-out";
        "g~" = "cd";
        gh = "cd";
        "g/" = "/";
        ee = "editor-open";
        V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';
      };
      settings = {
        preview = true;
        hidden = true;
        drawbox = true;
        icons = true;
        ignorecase = true;
      };
      extraConfig = let
        previewer = pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
    };
    ssh = {
      enable = true;
      matchBlocks = {
        "hi@dessa.dev" = {
          host = "gitlab.com github.com";
          identitiesOnly = true;
          identityFile = [
            "~/.ssh/id_dev"
          ];
        };
        "dess_key" = {
          host = "192.168.1.203";
          identitiesOnly = true;
          identityFile = ["~/.ssh/id_dess"];
        };
      };
    };
    bat.enable = true;
    eza.enable = true;
    man.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
      settings = {
        use-agent = true;
        default-key = "CC10324DD962CB7E";
      };
    };
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      lfs.enable = true;
      delta.enable = true;

      userName = "dess";
      userEmail = "hi@dessa.dev";
      signing = {
        key = "CC10324DD962CB7E";
        signByDefault = true;
      };

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
        nuke = "!git clean -xdf && git reset --hard && git pull";
        st = "status -sb";
        sync = "!git push && git pull";
        rs = "restore --staged";
        ll = "log --oneline";
        last = "log -1 HEAD --stat";
        cm = "commit -m";
        co = "checkout";
        rv = "remote -v";
        df = "diff HEAD";
        d = "diff";
      };

      extraConfig = {
        init.defaultBranch = "main";
        branch.autosetupmerge = "true";
        push.default = "current";
        merge.stat = "true";
        core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        repack.usedeltabaseoffset = "true";
        pull.ff = "only";
        rebase = {
          autoSquash = true;
          autoStash = true;
        };
        rerere = {
          enabled = true;
          autoupdate = true;
        };
      };
      ignores = [
        "*~"
        "*.swp"
        "*result*"
        ".direnv"
        "node_modules"
      ];
    };
    gh = {
      enable = true;
      settings = {
        editor = "vim";
        git_protocol = "ssh";
        aliases = {
          co = "pr checkout";
          rc = "repo clone";
        };
      };
    };
  };
  xdg.configFile."lf/icons".source = ./icons;
  home.sessionVariables = {
    NIX_AUTO_RUN = "1";
    FLAKE = "/home/dev/dev/flake";
  };

  imports = [inputs.nix-index-db.hmModules.nix-index];
  programs = {
    nix-index = {
      enable = true;
      symlinkToCacheHome = true;
      enableZshIntegration = false;
    };

    nix-index-database.comma.enable = true;
  };
}
