{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.generators) mkLuaInline;
in {
  den.aspects.nvf = {
    vim = {
      vim.ui.breadcrumbs = {
        enable = true;
        navbuddy = {
          enable = true;
          setupOpts = {
            icons = mkLuaInline "nvf_icons.kinds";
          };
        };
      };
      vim.keymaps = [
        # Better up/down
        (mkKeymap ["n"] "<leader>;" ":Navbuddy<cr>" {
          desc = "Open Navbuddy";
          unique = true;
        })
      ];
    };
  };
}
