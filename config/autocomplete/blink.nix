{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim.autocomplete.blink-cmp = {
    enable = true;
    friendly-snippets.enable = true;

    mappings = {
      next = "<Down>";
      previous = "<Up>";
    };

    setupOpts = {
      appearance.nerd_font_variant = "mono";
      appearance.kind_icons = mkLuaInline "nvf_icons.kinds";

      completion = {
        accept.auto_brackets.enabled = true;
        menu.draw.treesitter = ["lsp"];
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 100;
        };
        ghost_text.enabled = mkLuaInline "vim.g.ai_cmp";
      };

      signature.enabled = true;

      cmdline.enabled = false;

      keymap = {
        preset = "enter";
        "<C-y>" = ["select_and_accept"];
      };
    };
  };
}
