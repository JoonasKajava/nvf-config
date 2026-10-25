{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
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
          text =
            mkLuaInline
            /*
            lua
            */
            ''
              {
                [vim.diagnostic.severity.ERROR] = nvf_icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = nvf_icons.diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = nvf_icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = nvf_icons.diagnostics.Info,
              }
            '';
        };
      };
    };
  };
}
