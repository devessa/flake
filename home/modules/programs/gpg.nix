{
  config,
  pkgs,
  ...
}: {
  programs = {
    gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
      settings = {
        use-agent = true;
        default-key = "BC4072495F2567DE";
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableZshIntegration = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
