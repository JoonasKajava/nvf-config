{
  inputs,
  ...
}: {
  flake-file.inputs = {
    atone-nvim = {
      url = "github:XXiaoA/atone.nvim";
      flake = false;
    };
  };
  den.aspects.nvf = {
    vim = {pkgs,lib, ...}: let
      inherit (pkgs.vimUtils) buildVimPlugin;
      inherit (lib.nvim.binds) mkKeymap;
      package = buildVimPlugin {
        pname = "atone.nvim";
        version = inputs.atone-nvim.lastModifiedDate;
        src = inputs.atone-nvim;
      };
    in {
      lazy.plugins = {
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
  };
}
