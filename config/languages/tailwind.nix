{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
in {
  config.vim = {
    extraPackages = with pkgs; [tailwindcss-language-server];
    lazy.plugins = {
      "tailwind-tools.nvim" = {
        package = pkgs.vimPlugins.tailwind-tools-nvim;

        enabled = true;

        lazy = false;

        setupModule = "tailwind-tools";

        before =
          /*
          lua
          */
          ''
            require('lspconfig').tailwindcss.setup({
                filetypes = { "rust" },
            })
          '';

        setupOpts = lib.mkIf true {
          server = {
            override = true;
            settings = {
              experimental.classRegex = [''class: "(.*)"''];
              includeLanguages.rust = "html";
            };
          };
        };
      };
    };
  };
}
