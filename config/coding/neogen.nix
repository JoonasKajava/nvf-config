{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {
    vim.lazy.plugins = {
      "neogen" = {
        package = pkgs.vimPlugins.neogen;

        enabled = true;

        lazy = true;

        setupModule = "neogen";

        keys = [
          (mkKeymap "n" "<leader>cn" ''function() require("neogen").generate() end'' {
            desc = "Generate Annotations";
            unique = true;
            lua = true;
          })
        ];

        setupOpts = {
          snippet_engine = "luasnip";
        };
      };
    };
  };
}
