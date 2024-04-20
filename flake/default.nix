{
  imports = [
    ../home
    ../hosts
    ../pkgs
  ];

  systems = ["x86_64-linux"];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
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
