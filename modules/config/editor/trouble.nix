{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim = {
    lsp.trouble = {
      enable = true;
      mappings = {
        workspaceDiagnostics = "<leader>xx";
        documentDiagnostics = "<leader>xX";
        lspReferences = null;
        quickfix = "<leader>xQ";
        locList = "<leader>xL";
        symbols = null;
      };
    };
    lazy.plugins.trouble.keys = [
      (mkKeymap "n" "[q"
        /*
        lua
        */
        ''
          function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '' {
          desc = "Previous Trouble/Quickfix Item";
          lua = true;
          unique = true;
        })
      (mkKeymap "n" "]q"
        /*
        lua
        */
        ''
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '' {
          desc = "Next Trouble/Quickfix Item";
          lua = true;
          unique = true;
        })
    ];
  };
}
