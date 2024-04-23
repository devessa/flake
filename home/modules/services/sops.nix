{inputs, ...}: let
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/dess/.config/sops/age/keys.txt";

    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    secrets = {
      "private_keys/zero" = {
        path = "/home/dess/.ssh/id_zero";
      };
      "private_keys/dess" = {
        path = "/home/dess/.ssh/id_dess";
      };
    };
  };
}
