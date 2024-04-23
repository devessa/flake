{
  pkgs,
  config,
  ...
}: {
  users.users.kyodev = {
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    home = "/home/dess";

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
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_dess.pub)
    ];
  };
}
