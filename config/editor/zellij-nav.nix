{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {

    # TODO: Replace with smart-splits
    vim.lazy.plugins = {
      "zellij-nav.nvim" = {
        package = pkgs.vimPlugins.zellij-nav-nvim;

        enabled = true;

        lazy = false;

        setupModule = "zellij-nav";

        cmd = ["ZellijNavigateLeftTab" "ZellijNavigateDown" "ZellijNavigateUp" "ZellijNavigateRightTab"];

        keys = [
          (mkKeymap "n" "<c-h>" "<cmd>ZellijNavigateLeftTab<cr>" { desc = "navigate left"; unique = true; })
          (mkKeymap "n" "<c-j>" "<cmd>ZellijNavigateDown<cr>" { desc = "navigate down"; unique = true; })
          (mkKeymap "n" "<c-k>" "<cmd>ZellijNavigateUp<cr>" { desc = "navigate up"; unique = true; })
          (mkKeymap "n" "<c-h>" "<cmd>ZellijNavigateRightTab<cr>" { desc = "navigate right"; unique = true; })
        ];
      };
    };
  };
}
