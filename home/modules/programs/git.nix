{pkgs, ...}: {
  home.packages = with pkgs; [
    zsh-forgit
  ];

  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      lfs.enable = true;
      delta.enable = true;

      userName = "dess";
      userEmail = "hi@dessa.dev";
      signing = {
        key = "BC4072495F2567DE";
        signByDefault = true;
      };

      aliases = {
        lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
        nuke = "!git clean -xdf && git reset --hard && git pull";
        st = "status -sb";
        rs = "restore --staged";
        ll = "log --oneline";
        last = "log -1 HEAD --stat";
        cm = "commit -m";
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
}
