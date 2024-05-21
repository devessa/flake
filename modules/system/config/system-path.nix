{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      starship
      vim
      ntfs3g
    ];
  };
}
