{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.ui.noice = {
    enable = true;
    setupOpts = {
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
      };
      routes = [
        {
          filter = {
            event = "msg_show";
            any = [
              {find = "%d+L, %d+B";}
              {find = "; after #%d+";}
              {find = "; before #%d+";}
            ];
          };
          view = "mini";
        }
      ];
      presets = {
        bottom_search = true;
        command_palette = true;
        long_message_to_split = true;
      };
    };
  };

  vim.keymaps = [
    (mkKeymap "n" "<leader>sn" "" {desc = "+noice";})
    (mkKeymap "c" "<S-Enter>" ''function() require("noice").redirect(vim.fn.getcmdline()) end'' {
      desc = "Redirect Cmdline";
      lua = true;
      unique = true;
    })
    (mkKeymap "n" "<leader>snl" ''function() require("noice").cmd("last") end'' {
      desc = "Noice Last Message";
      lua = true;
      unique = true;
    })
    (mkKeymap "n" "<leader>snh" ''function() require("noice").cmd("history") end'' {
      desc = "Noice History";
      lua = true;
      unique = true;
    })
    (mkKeymap "n" "<leader>sna" ''function() require("noice").cmd("all") end'' {
      desc = "Noice All";
      lua = true;
      unique = true;
    })
    (mkKeymap "n" "<leader>snd" ''function() require("noice").cmd("dismiss") end'' {
      desc = "Dismiss All";
      lua = true;
      unique = true;
    })
    (mkKeymap "n" "<leader>snt" ''function() require("noice").cmd("pick") end'' {
      desc = "Noice Picker (Telescope/FzfLua)";
      lua = true;
      unique = true;
    })
    (mkKeymap ["i" "n" "s"] "<c-f>" ''function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end'' {
      silent = true;
      expr = true;
      desc = "Scroll Forward";
      lua = true;
      unique = true;
    })
    (mkKeymap ["i" "n" "s"] "<c-b>" ''function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end'' {
      silent = true;
      expr = true;
      desc = "Scroll Backward";
      lua = true;
      unique = true;
    })
  ];
}
