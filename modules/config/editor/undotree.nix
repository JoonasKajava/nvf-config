{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.nvim.binds) mkKeymap;
in {
  # Replaced by Snacks.picker.undo()
  config = mkIf false {
    vim = {
      lazy.plugins = {
        "undotree" = {
          package = pkgs.vimPlugins.undotree;

          enabled = true;

          lazy = true;

          keys = [
            (mkKeymap "n" "<leader>ut" ":UndotreeToggle<cr>" {
              desc = "Toggle Undotree";
              unique = true;
            })
          ];

          cmd = ["UndotreeToggle"];
        };
      };
    };
  };
}
