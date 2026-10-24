{
  den.aspects.nvf = {
    vim.luaConfigRC.extraAutocmds = builtins.readFile ./autocmds.lua;
  };
}
