{lib, ...}: let
  icons = import ../_icons.nix;
in {
  den.aspects.nvf = {
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
            # TODO: this might not work
            # I might need to convert this into pure lua
            "vim.diagnostic.severity.ERROR" = icons.diagnostics.Error;
            "vim.diagnostic.severity.WARN" = icons.diagnostics.Warn;
            "vim.diagnostic.severity.HINT" = icons.diagnostics.Hint;
            "vim.diagnostic.severity.INFO" = icons.diagnostics.Info;
          };
        };
      };
    };
  };
}
