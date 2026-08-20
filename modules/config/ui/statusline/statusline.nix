{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  den.aspects.nvf.vim = {pkgs,...}: {
    lazy.plugins = {
      "lualine.nvim" = {
        package = pkgs.vimPlugins.lualine-nvim;

        enabled = true;

        lazy = true;

        event = ["BufEnter"];

        setupModule = "lualine";

        before = builtins.readFile ./lualine_utils.lua;

        setupOpts = mkLuaInline (builtins.readFile ./lualine.lua);
      };
    };
  };
}
