{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.ui.breadcrumbs = {
    enable = true;
    navbuddy = {
      enable = true;
    };
  };
  vim.keymaps = [
    # Better up/down
    (mkKeymap ["n"] "<leader>;" ":Navbuddy<cr>" {
      desc = "Open Navbuddy";
      unique = true;
    })
  ];
}
