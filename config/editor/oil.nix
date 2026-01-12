{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {
    vim.lazy.plugins = {
      "oil.nvim" = {
        package = pkgs.vimPlugins.oil-nvim;

        enabled = true;

        lazy = true;

        setupModule = "oil";

        cmd = ["Oil"];

        keys = [
          (mkKeymap "n" "<leader>e" ":Oil --float<cr>" {
            desc = "Open Oil file explorer";
            unique = true;
          })
        ];

        setupOpts = {
          default_file_explorer = true;
          view_options.show_hidden = true;
        };
      };
    };
  };
}
