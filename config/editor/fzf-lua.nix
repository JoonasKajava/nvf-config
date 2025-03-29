{
  lib,
  config,
  pkgs,
  ...
}: {
  vim.fzf-lua = {
    enable = true;
    setupOpts = let
      actions = "require('fzf-lua').actions";
    in {
      files = {
        cwd_prompt = false;
        actions = {
          # TODO: These do not work
          "alt-i" = ["${actions}.toggle_ignore"];
          "alt-h" = ["${actions}.toggle_hidden "];
        };
      };
      grep = {
        actions = {
          "alt-i" = ["${actions}.toggle_ignore"];
          "alt-h" = ["${actions}.toggle_hidden "];
        };
      };
    };
  };

  vim.extraPackages = with pkgs; lib.mkIf config.vim.fzf-lua.enable [fzf];

  vim.keymaps = lib.mkIf config.vim.fzf-lua.enable [
    {
      key = "<leader><space>";
      mode = ["n"];
      action = "<cmd>FzfLua files<cr>";
      desc = "Find Files";
      unique = true;
    }
  ];
}
