{
  homeImports,
  inputs,
  self,
  ...
}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;

  modules = "${self}/modules/system";
  profiles = "${self}/hosts/profiles";

  specialArgs = {inherit inputs self;};
in {
  flake.nixosConfigurations = {
    nori = nixosSystem {
      inherit specialArgs;

      modules = [
        ./nori

        "${modules}/config"
        "${modules}/programs"
        "${modules}/security"
        "${modules}/services"
        "${modules}/virtualisation/docker.nix"
        "${profiles}/gnome"

        {
          home-manager = {
            users.kd.imports = homeImports."kd@nori";
            extraSpecialArgs = specialArgs;
          };
        }
      ];
    };
  };
}
