{
  den.aspects.nvf = {
    vim = {lib, ...}: let
      inherit (lib.nvim.binds) mkKeymap;
    in {
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
          picker = {
            ui_select = true;
          };

          dashboard = {
            enabled = true;
            sections = [
              {section = "header";}
              {
                section = "keys";
                gap = 1;
                padding = 1;
              }
            ];
            preset.keys = [
              {
                action = "<cmd>FzfLua files<cr>";
                desc = " Find File";
                icon = " ";
                key = "f";
              }
              {
                action = "<cmd>FzfLua live_grep<cr>";
                desc = " Find Text";
                icon = " ";
                key = "g";
              }
              {
                action = "ene | startinsert";
                desc = " New File";
                icon = " ";
                key = "n";
              }
              {
                action = ":lua Snacks.dashboard.pick('oldfiles')";
                desc = " Recent Files";
                icon = " ";
                key = "r";
              }
              {
                action = ":qa";
                desc = " Quit";
                icon = " ";
                key = "q";
              }
            ];
          };
        };
      };

      keymaps = [
        (mkKeymap "n" "<leader>gg" "function() Snacks.lazygit() end" {
          desc = "Launch Lazygit";
          lua = true;
        })

        (mkKeymap "n" "<leader>gb" "function() Snacks.lazygit.log_file() end" {
          desc = "Buffer commits (git)";
          lua = true;
        })

        (mkKeymap "n" "<leader>gc" "function() Snacks.lazygit.log() end" {
          desc = "Commits (git)";
          lua = true;
        })

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

        # (mkKeymap "n" "<leader>ut"
        #   # lua
        #   "function() Snacks.picker.undo() end" {
        #     desc = "Toggle Undotree";
        #     unique = true;
        #     lua = true;
        #   })

        (mkKeymap "n" "<leader>jm"
          # lua
          "function() Snacks.picker.marks() end" {
            desc = "Jump to Mark";
            unique = true;
            lua = true;
          })

        (mkKeymap "n" "<leader>xD"
          # lua
          "function() Snacks.picker.diagnostics() end" {
            desc = "View Diagnostics";
            unique = true;
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
  };
}
