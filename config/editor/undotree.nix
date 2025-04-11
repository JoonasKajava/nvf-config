{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = mkIf true {
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
