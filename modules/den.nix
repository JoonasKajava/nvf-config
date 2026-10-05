{
  inputs,
  den,
  ...
}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  perSystem = {pkgs, ...}: let
    # custom den.lib.nvf from ./nvf-integration.nix
    nvf = den.lib.nvf.package pkgs;
  in {
    packages.default = nvf den.aspects.nvf {};
  };
}
