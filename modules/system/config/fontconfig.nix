{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;

      antialias = true;

      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["code" "Noto Color Emoji" "Symbols Nerd Font"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["type" "Work Sans" "Noto Color Emoji"];
      };

      hinting = {
        enable = true;
        autohint = false;
        style = "full";
      };

      subpixel = {
        lcdfilter = "default";
        rgba = "rgb";
      };
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };

    packages = with pkgs; [
      material-design-icons
      liberation_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      (google-fonts.override {fonts = ["Work Sans"];})
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
