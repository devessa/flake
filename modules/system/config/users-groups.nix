{
  pkgs,
  config,
  ...
}: {
  users.users.dev = {
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
    home = "/home/dev";

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
      (builtins.readFile ./id_dev.pub)
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
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_dev.pub)
    ];
  };
}
