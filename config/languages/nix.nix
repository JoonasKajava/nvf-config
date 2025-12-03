{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  use-nixd = false;

  cfg = config.vim.languages.nix;
in {
  vim.languages.nix = {
    enable = true;
    lsp = {
      servers = mkIf use-nixd ["nixd"];
    };
  };
  vim.lsp.servers = mkIf (builtins.elem "nil" cfg.lsp.servers) {
    nil.settings.nil = {
      nix = {
        autoArchive = true;
        autoEvalInputs = true;
      };
    };
  };
}
