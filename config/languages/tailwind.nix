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

        lazy = true;

        event = ["LspAttach"];

        setupModule = "tailwind-tools";

        setupOpts = {
          server = {
            settings = {
              experimental.classRegex = ["class: \"(.*)\""];
              includeLanguages.rust = "html";
            };
          };
        };
      };
    };
  };
}
