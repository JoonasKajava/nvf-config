{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  use-nixd = true;

  cfg = config.vim.languages.nix;
in {
  vim = {
    languages.nix = {
      enable = true;
      lsp = {
        servers = mkIf use-nixd ["nixd"];
      };
    };
    lsp.servers = {
      nil = mkIf (builtins.elem "nil" cfg.lsp.servers) {
        settings.nil = {
          nix.flake = {
            autoArchive = true;
            autoEvalInputs = true;
          };
        };
      };

      nixd = mkIf (builtins.elem "nixd" cfg.lsp.servers) {
        settings = {
          options = {
            "home-manager" = {
              "expr" = ''(builtins.getFlake "/etc/nixos").homeConfigurations.joonas.options'';
            };
            "nixos-desktop" = {
              "expr" = ''(builtins.getFlake "/etc/nixos").nixosConfigurations.nixos-desktop.options'';
            };
          };
        };
      };
    };
  };
}
