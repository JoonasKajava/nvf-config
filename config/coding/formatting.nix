{lib, ...}: {
  vim = rec {
    options.formatexpr = lib.mkIf formatter.conform-nvim.enable "v:lua.require'conform'.formatexpr()";
    formatter.conform-nvim = {
      "enable" = true;
      setupOpts = {
        default_format_opts = {
          timeout_ms = 3000;
          async = false;
          quiet = false;
          lsp_format = "fallback";
        };
        formatters_by_ft = {
          lua = ["stylua"];
          sh = ["shfmt"];
        };
        formatters = {
          # Look https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md#injected
          injected = {
            options = {
              # Set to true to ignore errors
              ignore_errors = false;
              # Map of treesitter language to filetype
              lang_to_ft = {
                bash = "sh";
              };
              # Map of treesitter language to file extension
              # A temporary file name with this extension will be generated during formatting
              # because some formatters care about the filename.
              lang_to_ext = {
                bash = "sh";
                c_sharp = "cs";
                elixir = "exs";
                javascript = "js";
                julia = "jl";
                latex = "tex";
                markdown = "md";
                python = "py";
                ruby = "rb";
                rust = "rs";
                teal = "tl";
                typescript = "ts";
              };
              # Map of treesitter language to formatters to use
              # (defaults to the value from formatters_by_ft)
              lang_to_formatters = {};
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = ["n" "v"];
        key = "<leader>lF";
        action =
          /*
          lua
          */
          ''
            function()
              require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
            end
          '';
        lua = true;
        desc = "Format Injected Langs";
      }
    ];
  };
}
