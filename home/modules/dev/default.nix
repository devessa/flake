{
  lib,
  pkgs,
  ...
}: {
  imports = [];
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        bruno
        just
        nil
        alejandra
        ;
    };
  };
}
