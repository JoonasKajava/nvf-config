{
  inputs,
  den,
  ...
}: {
  imports = [
    (inputs.flake-file.flakeModules.dendritic or {})
    (inputs.den.flakeModules.dendritic or {})
  ];

  perSystem = {
    pkgs,
    system,
    ...
  }: let
    # custom den.lib.nvf from ./nvf-integration.nix
    nvf = den.lib.nvf.package pkgs;
  in {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    packages.default = nvf den.aspects.nvf {};
  };
}
