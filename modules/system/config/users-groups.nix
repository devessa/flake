{pkgs, ...}: {
  users.mutableUsers = false;
  sops.secrets.kd-password.neededForUsers = true;
  users.users.kd = {
    isNormalUser = true;
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
      (builtins.readFile ./id_zero.pub)
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
}
