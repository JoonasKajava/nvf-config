{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {
    vim.lazy.plugins = {
      "zellij-nav.nvim" = {
        package = pkgs.vimPlugins.zellij-nav-nvim;

        enabled = true;

        lazy = true;

        setupModule = "zellij-nav";

        cmd = ["ZellijNavigateLeft" "ZellijNavigateDown" "ZellijNavigateUp" "ZellijNavigateRight"];

        keys = [
          (mkKeymap "n" "<c-h>" "<cmd>ZellijNavigateLeft<cr>" { desc = "navigate left"; unique = true; })
          (mkKeymap "n" "<c-j>" "<cmd>ZellijNavigateDown<cr>" { desc = "navigate down"; unique = true; })
          (mkKeymap "n" "<c-k>" "<cmd>ZellijNavigateUp<cr>" { desc = "navigate up"; unique = true; })
          (mkKeymap "n" "<c-h>" "<cmd>ZellijNavigateRight<cr>" { desc = "navigate right"; unique = true; })
        ];
      };
    };
  };
}
