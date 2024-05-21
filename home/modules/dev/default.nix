{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = lib.attrValues {
      inherit
        (pkgs)
        bruno
        just
        nil
        alejandra
        corepack
        ;
    };
  };
}
