{
  lib,
  config,
  pkgs,
  ...
}: {
  vim.fzf-lua = {
    enable = true;
    setupOpts = let
      mkAction = action: lib.generators.mkLuaInline "require('fzf-lua').actions.${action}";
    in {
      files = {
        cwd_prompt = false;
        actions = {
          "alt-i" = [(mkAction "toggle_ignore")];
          "alt-h" = [(mkAction "toggle_hidden")];
        };
      };
      grep = {
        actions = {
          "alt-i" = [(mkAction "toggle_ignore")];
          "alt-h" = [(mkAction "toggle_hidden")];
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
    {
      key = "<leader>/";
      mode = ["n"];
      action = "<cmd>FzfLua live_grep<cr>";
      desc = "Live Grep";
      unique = true;
    }
    {
      key = "<leader>ss";
      mode = ["n"];
      action = "<cmd>FzfLua lsp_document_symbols<cr>";
      desc = "Document Symbols";
      unique = true;
    }
    {
      key = "<leader>,";
      mode = ["n"];
      action = "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>";
      desc = "Switch Buffer";
      unique = true;
    }
    {
      key = "<leader>gc";
      mode = ["n"];
      action = "<cmd>FzfLua git_commits<cr>";
      desc = "Commits";
      unique = true;
    }
    {
      key = "<leader>s\"";
      mode = ["n"];
      action = "<cmd>FzfLua registers<cr>";
      desc = "Registers";
      unique = true;
    }
    {
      key = "<leader>sb";
      mode = ["n"];
      action = "<cmd>FzfLua grep_curbuf<cr>";
      desc = "Grep Current Buffer";
      unique = true;
    }
    {
      key = "<leader>sc";
      mode = ["n"];
      action = "<cmd>FzfLua commands<cr>";
      desc = "Commands";
      unique = true;
    }
    {
      key = "<leader>sd";
      mode = ["n"];
      action = "<cmd>FzfLua diagnosticts_document<cr>";
      desc = "Document Diagnostics";
      unique = true;
    }
    {
      key = "<leader>sD";
      mode = ["n"];
      action = "<cmd>FzfLua diagnosticts_workspace<cr>";
      desc = "Workspace Diagnostics";
      unique = true;
    }
    {
      key = "<leader>sk";
      mode = ["n"];
      action = "<cmd>FzfLua keymaps<cr>";
      desc = "Keymaps";
      unique = true;
    }
    {
      key = "<leader>sm";
      mode = ["n"];
      action = "<cmd>FzfLua marks<cr>";
      desc = "Jump to Mark";
      unique = true;
    }
    {
      key = "gd";
      mode = ["n"];
      action = "<cmd>FzfLua lsp_definitions jump1=true ignore_current_line=true<cr>";
      desc = "Goto Definition";
      unique = true;
    }
    {
      key = "gr";
      mode = ["n"];
      action = "<cmd>FzfLua lsp_references jump1=true ignore_current_line=true<cr>";
      desc = "References";
      nowait = true;
      unique = true;
    }
    {
      key = "gI";
      mode = ["n"];
      action = "<cmd>FzfLua lsp_implementations jump1=true ignore_current_line=true<cr>";
      desc = "Goto Implementation";
      unique = true;
    }
    {
      key = "gy";
      mode = ["n"];
      action = "<cmd>FzfLua lsp_typedefs jump1=true ignore_current_line=true<cr>";
      desc = "Goto T[y]pe Definition";
      unique = true;
    }
  ];

  # TODO: add todo-comments keymap
}
