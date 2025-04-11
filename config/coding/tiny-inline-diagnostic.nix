{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkForce;
in {
  config = mkIf true {
    vim = {
      lazy.plugins = {
        "tiny-inline-diagnostic.nvim" = {
          package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;

          enabled = true;

          lazy = true;

          event = ["LspAttach"];

          priority = 99999;

          setupModule = "tiny-inline-diagnostic";

          setupOpts = {
            preset = "powerline";
          };
        };
      };
      diagnostics.config.virtual_text = mkForce false;
    };
  };
}
