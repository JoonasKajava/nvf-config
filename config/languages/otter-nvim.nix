{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim = rec {
    lsp.otter-nvim = {
      enable = true;
    };
    autocmds = lib.mkIf
      false
      # lsp.otter-nvim.enable
      [
      {
        enable = true;
        desc = "Automatically activate Otter when opening a file";
        event = ["Filetype"];
        callback =
          mkLuaInline
          # lua
          ''
            function ()
              local excludedTypes = {"oil", "fzflua_backdrop", "fzf", "snacks_notif", "noice"}
              if vim.tbl_contains(excludedTypes, vim.bo.filetype) then
                return
              end

              -- vim.print("Activating Otter for filetype: " .. vim.bo.filetype)
              require('otter').activate()
            end
          '';
      }
    ];
  };
}
