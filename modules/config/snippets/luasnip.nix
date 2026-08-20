{
  lib,
  config,
  ...
}: {
  options.vim.snippets.luasnip.snippetStop = lib.mkOption {
    type = lib.types.str;
    default =
      if config.vim.snippets.luasnip.enable
      then
        # lua
        ''
          if require("luasnip").expand_or_jumpable() then
            require("luasnip").unlink_current()
          end''
      else "";
    description = "Lua code to stop snippet expansion.";
  };
  config.vim.snippets.luasnip = {
    enable = true;
    setupOpts = {
      history = true;
      delete_check_events = "TextChanged";
    };
  };
}
