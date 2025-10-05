{lib,config, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib) mkIf;
in {
  imports = [
    ./dashboard.nix
  ];

  vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        bigfile.enabled = true;
        quickfile.enabled = true;

        indent.enabled = true;
        input.enabled = true;
        notifier.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = false;
        toggle.enabled = false;
        words.enabled = true;

        lazygit.enabled = true;
      };
    };

    keymaps = [
      (mkIf config.vim.utility.snacks-nvim.setupOpts.lazygit.enabled (mkKeymap "n" "<leader>gg" "function() Snacks.lazygit() end" {
        desc = "Toggle Scratch Buffer";
        lua = true;
      }))
      (mkKeymap "n" "<leader>." "function() Snacks.scratch() end" {
        desc = "Toggle Scratch Buffer";
        lua = true;
      })
      (mkKeymap "n" "<leader>S" "function() Snacks.scratch.select() end" {
        desc = "Select Scratch Buffer";
        lua = true;
      })
      (mkKeymap "n" "<leader>dps" "function() Snacks.profiler.scratch() end" {
        desc = "Profiler Scratch Buffer";
        lua = true;
      })

      (mkKeymap "n" "<leader>n"
        /*
        lua
        */
        ''
          function()
            if Snacks.config.picker and Snacks.config.picker.enabled then
              Snacks.picker.notifications()
            else
              Snacks.notifier.show_history()
            end
          end
        '' {
          desc = "Notification History";
          lua = true;
          unique = true;
        })

      (mkKeymap "n" "<leader>un" "function() Snacks.notifier.hide() end" {
        desc = "Dismiss All Notifications";
        lua = true;
      })
    ];
  };
}
