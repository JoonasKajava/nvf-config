{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.generators) mkLuaInline;
in {
  config = {
    vim.visuals.nvim-web-devicons.enable = true;

    vim.lazy.plugins = {
      "dropbar.nvim" = {
        package = pkgs.vimPlugins.dropbar-nvim;

        enabled = true;

        lazy = false; # Lazy-loading is apparently done by the plugin itself

        setupModule = "dropbar";

        setupOpts = {
        };
      };
    };
  };
}
