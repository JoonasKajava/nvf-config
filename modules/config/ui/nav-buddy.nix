{lib, ...}: {
  den.aspects.nvf = {
    vim = {lib, ...}: let
      inherit (lib.nvim.binds) mkKeymap;
      inherit (lib.generators) mkLuaInline;
    in {
      statusline.lualine.integrations.breadcrumbs = {
        navbuddy = {
          enable = true;
          setupOpts = {
            icons = mkLuaInline "nvf_icons.kinds";
          };
        };
      };
      keymaps = [
        # Better up/down
        (mkKeymap ["n"] "<leader>;" ":Navbuddy<cr>" {
          desc = "Open Navbuddy";
          unique = true;
        })
      ];
    };
  };
}
