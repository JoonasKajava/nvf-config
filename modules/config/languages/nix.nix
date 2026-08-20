{lib, ...}: let
  inherit (lib) mkIf;
  use-nixd = true;
in {
  den.aspects.nvf.vim = {config, ...}: let
    cfg = config.vim.languages.nix;
  in {
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
