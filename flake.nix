{
  description = ''        __ _       _
     / _| | __ _| | _____
    | |_| |/ _` | |/ / _ \
    |  _| | (_| |   <  __/
    |_| |_|\__,_|_|\_\___|

    kyolinedev's nixos configuration.
  '';

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} {imports = [./flake];};

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/NUR";
    nh.url = "github:viperML/nh";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:mic92/sops-nix";

    mysecrets = {
      url = "git+ssh://git@192.168.1.203:22/zero/sops.git?ref=main&shallow=1";
      flake = false;
    };

    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nh.inputs.nixpkgs.follows = "nixpkgs";
  };
}
