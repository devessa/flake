{pkgs, config, ...}: {
  users.mutableUsers = false;
  sops.secrets.kd-password.neededForUsers = true;
  sops.secrets.root-password.neededForUsers = true;

  users.users.kd = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.kd-password.path;
    shell = pkgs.zsh;
    uid = 1000;

    extraGroups = [
      "adbusers"
      "audio"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
    ];

    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_dess.pub)
    ];

    packages = with pkgs; [
      spotify
      kate
      vscode
      gh
      rnote
      libnotify
      libreoffice-qt
      bottom
      vlc
      fzf
      floorp
    ];
  };

  users.users.root = {
    hashedPasswordFile = config.sops.secrets.root-password.path;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_dess.pub)
    ];
  };
}
