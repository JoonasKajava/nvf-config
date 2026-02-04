{
  pkgs,
  atone-nvim,
  lib,
  ...
}: let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (lib.nvim.binds) mkKeymap;
  package = buildVimPlugin {
    pname = "atone.nvim";
    version = atone-nvim.lastModifiedDate;
    src = atone-nvim;
  };
in {
  config = {
    vim.lazy.plugins = {
      "atone.nvim" = {
        inherit package;
        enabled = true;
        setupModule = "atone";
        keys = [
          (mkKeymap "n" "<leader>ut" "<Cmd>Atone<CR>" {desc = "Undo tree";})
        ];
      };
    };
  };
}
