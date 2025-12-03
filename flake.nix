{
  description = "A nvf configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nvf.url = "github:notashelf/nvf/v0.8";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    flake-parts,
    nvf,
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
