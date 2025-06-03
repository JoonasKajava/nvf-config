{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim = rec {
    lsp.otter-nvim = {
      enable = true;
    };
    autocmds = lib.mkIf lsp.otter-nvim.enable [
      {
        enable = true;
        desc = "Automatically activate Otter when opening a file";
        event = ["Filetype"];
        callback =
          mkLuaInline
          # lua
          ''
            function ()
              require('otter').activate()
            end
          '';
      }
    ];
  };
}
