{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {
    vim.startPlugins = [
      "plenary-nvim"
    ];
    vim.lazy.plugins = {
      "yazi.nvim" = {
        package = pkgs.vimPlugins.yazi-nvim;

        enabled = true;

        lazy = true;

        cmd = ["Yazi"];

        setupModule = "yazi";

        keys = [
          (mkKeymap "n" "<leader>e"
            ''<cmd>Yazi<cr>'' {
              desc = "Open Yazi File Explorer";
              unique = true;
            })
        ];

        setupOpts = {
          open_for_directories = true;
        };
      };
    };
  };
}
