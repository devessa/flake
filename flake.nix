{
  description = ''        __ _       _
     / _| | __ _| | _____
    | |_| |/ _` | |/ / _ \
    |  _| | (_| |   <  __/
    |_| |_|\__,_|_|\_\___|

    kyolinedev's nixos configuration.
  '';

  outputs = inputs: let
    inherit (inputs.home-manager.lib) homeManagerConfiguration;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            deadnix
            git
            nil
          ];
          name = "dev-pc";
          meta.description = "default devshell";
          DIRENV_LOG_FORMAT = "";
        };
        formatter = pkgs.alejandra;
      };

      flake = {
        homeConfigurations = {
          "dev" = homeManagerConfiguration {
            extraSpecialArgs = {inherit inputs;};
            inherit pkgs;
            modules = [./home.nix];
          };
        };
      };
    };

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nh.url = "github:viperML/nh";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-index-db.url = "github:mic92/nix-index-database";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-db.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
  };
}
