{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
in {
  config = mkIf true {
    vim = {
      lazy.plugins = {
        "refactoring.nvim" = {
          package = pkgs.vimPlugins.refactoring-nvim;
          enabled = true;
          lazy = true;
          event = ["LspAttach"];
          setupModule = "refactoring";

          keys = [
            {
              mode = ["n" "x"];
              key = "<leader>cr";
              desc = "+refactor";
            }
            {
              key = "<leader>crr";
              mode = ["n" "x"];
              desc = "Select Refactor";
              action =
                /*
                lua
                */
                ''
                  function()
                    require('refactoring').select_refactor()
                  end
                '';
              lua = true;
            }
            {
              key = "<leader>crpp";
              mode = ["n"];
              desc = "Print To Console";
              action =
                /*
                lua
                */
                ''
                  function()
                    require("refactoring").debug.printf()
                  end
                '';
              lua = true;
            }
            {
              key = "<leader>crpc";
              desc = "Cleanup Console Prints";
              mode = ["n"];
              action =
                /*
                lua
                */
                ''
                  function()
                    require("refactoring").debug.cleanup()
                  end
                '';
              lua = true;
            }
          ];
        };
      };
    };
  };
}
