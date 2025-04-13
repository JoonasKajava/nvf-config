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

        # TODO: tailwind-tools should add these automatically according to the repo
        # But for some reason this does not work on rust.
        setupOpts = lib.mkIf false {
          server = {
            override = true;
            settings = {
              experimental.classRegex = [''class: "(.*)"''];
              includeLanguages.rust = "html";
            };
          };
          extension = {
            rust = ["class=[\"']([^\"']+)[\"']"];
          };
        };
      };
    };
  };
}
