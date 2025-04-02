{
  pkgs,
  config,
  lib,
  ...
}: {
  config = {
    vim.lazy.plugins = {
      "grug-far.nvim" = {
        package = pkgs.vimPlugins.grug-far-nvim;

        enabled = true;

        setupModule = "grug-far";

        setupOpts = {
          headerMaxWidth = 80;
        };

        cmd = ["GrugFar"];

        keys = [
          {
            key = "<leader>sr";
            action =
              /*
              lua
              */
              ''
                function()
                  local grug = require("grug-far")
                  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
                  grug.open({
                    transient = true,
                    prefills = {
                      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
                    },
                  })
                end'';
            lua = true;
            mode = ["n" "v"];
            desc = "Search and Replace";
          }
        ];
      };
    };
    vim.extraPackages = lib.mkIf config.vim.lazy.plugins."grug-far.nvim".enabled [
      pkgs.ripgrep
    ];
  };
}
