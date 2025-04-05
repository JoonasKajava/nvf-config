{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.generators) mkLuaInline;
in {
  config = {
    vim.visuals.nvim-web-devicons.enable = true;

    vim.lazy.plugins = {
      "bufferline.nvim" = {
        package = pkgs.vimPlugins.bufferline-nvim;

        enabled = true;

        lazy = false;

        setupModule = "bufferline";

        keys = [
          (mkKeymap "n" "<leader>bp" "<Cmd>BufferLineTogglePin<CR>" {desc = "Toggle Pin";})
          (mkKeymap "n" "<leader>bP" "<Cmd>BufferLineGroupClose ungrouped<CR>" {desc = "Delete Non-Pinned Buffers";})
          (mkKeymap "n" "<leader>br" "<Cmd>BufferLineCloseRight<CR>" {desc = "Delete Buffers to the Right";})
          (mkKeymap "n" "<leader>bl" "<Cmd>BufferLineCloseLeft<CR>" {desc = "Delete Buffers to the Left";})
          (mkKeymap "n" "<S-h>" "<cmd>BufferLineCyclePrev<cr>" {desc = "Prev Buffer";})
          (mkKeymap "n" "<S-l>" "<cmd>BufferLineCycleNext<cr>" {desc = "Next Buffer";})
          (mkKeymap "n" "[b" "<cmd>BufferLineCyclePrev<cr>" {desc = "Prev Buffer";})
          (mkKeymap "n" "]b" "<cmd>BufferLineCycleNext<cr>" {desc = "Next Buffer";})
          (mkKeymap "n" "[B" "<cmd>BufferLineMovePrev<cr>" {desc = "Move buffer prev";})
          (mkKeymap "n" "]B" "<cmd>BufferLineMoveNext<cr>" {desc = "Move buffer next";})
        ];

        setupOpts = {
          options = {
            close_command = mkLuaInline "function(n) Snacks.bufdelete(n) end";
            right_mouse_command = mkLuaInline "function(n) Snacks.bufdelete(n) end";
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
            diagnostics_indicator =
              mkLuaInline
              /*
              lua
              */
              ''
                function(_, _, diag)
                  local icons = nvf_icons.diagnostics;
                  local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                    .. (diag.warning and icons.Warn .. diag.warning or "")
                  return vim.trim(ret)
                end
              '';
            offsets = [
              {
                filetype = "neo-tree";
                text = "Neo-tree";
                highlight = "Directory";
                text_align = "left";
              }
              {
                filetype = "snacks_layout_box";
              }
            ];
            get_element_icon = mkLuaInline ''function(opts) return nvf_icons.ft[opts.filetype] end'';
          };
        };

        after =
          /*
          lua
          */
          ''
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
              callback = function()
                vim.schedule(function()
                  pcall(nvim_bufferline)
                end)
              end,
            })
          '';
      };
    };
  };
}
