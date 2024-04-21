{
  imports = [
    ../home
    ../hosts
  ];

  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        deadnix
        git
        nil
      ];

      name = "nori";
      meta.description = "default devshell";

      DIRENV_LOG_FORMAT = "";
    };

    formatter = pkgs.alejandra;
  };
}
