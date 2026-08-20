{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.generators) mkLuaInline;
in {
  config = {
    vim.lazy.plugins = {
      "mini.icons" = {
        package = pkgs.vimPlugins.mini-icons;

        enabled = true;

        lazy = true;

        setupModule = "mini.icons";

        before =
          /*
          lua
          */
          ''
            package.preload["nvim-web-devicons"] = function()
              require("mini.icons").mock_nvim_web_devicons()
              return package.loaded["nvim-web-devicons"]
            end
          '';

        setupOpts = {
          file = {
            ".keep" = {
              glyph = "󰊢";
              hl = "MiniIconsGrey";
            };
            "devcontainer.json" = {
              glyph = "";
              hl = "MiniIconsAzure";
            };
          };
          filetype = {
            dotenv = {
              glyph = "";
              hl = "MiniIconsYellow";
            };
          };
        };
      };
    };
  };
}
