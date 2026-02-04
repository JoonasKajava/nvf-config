{
  description = "A nvf configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    atone-nvim = {
      url = "github:XXiaoA/atone.nvim";
      flake = false;
    };
  };

  outputs = {
    flake-parts,
    nvf,
    atone-nvim,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {system, ...}: let
        nvim =
          (nvf.lib.neovimConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages.${system};
            extraSpecialArgs = {
              inherit (inputs) atone-nvim;
            };
            modules = [
              ./config
            ];
          })
          .neovim;
      in {
        packages = {
          default = nvim;
        };
      };
    };
}
