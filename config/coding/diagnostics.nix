{lib, ...}: let
  icons = import ../icons.nix;
in {
  vim.diagnostics = {
    enable = true;
    config = {
      underline = true;
      update_in_insert = false;
      virtual_text = {
        prefix = "●";
        source = "if_many";
        spacing = 4;
      };
      severity_sort = true;
      signs = {
        text = {
          "vim.diagnostic.severity.ERROR" = icons.diagnostics.Error;
          "vim.diagnostic.severity.WARN" = icons.diagnostics.Warn;
          "vim.diagnostic.severity.HINT" = icons.diagnostics.Hint;
          "vim.diagnostic.severity.INFO" = icons.diagnostics.Info;
        };
      };
    };
  };
}
