{lib, ...}: let
  inherit (lib.generators) mkLuaInline;
in {
  vim.mini.pairs.enable = true;
  vim.mini.pairs.setupOpts = {
    modes = {
      insert = true;
      command = true;
      terminal = false;
    };
    # skip autopair when next character is one of these
    skip_next = mkLuaInline "[=[[%w%%%'%[%\"%.%`%$]]=]";
    # skip autopair when the cursor is inside these treesitter nodes
    skip_ts = ["string"];
    # skip autopair when next character is closing pair
    # and there are more closing pairs than opening pairs
    skip_unbalanced = true;
    # better deal with markdown code blocks
    markdown = true;
  };
}
