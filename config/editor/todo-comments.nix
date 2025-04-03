{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  config = {
    vim.lazy.plugins = {
      "todo-comments.nvim" = {
        package = pkgs.vimPlugins.todo-comments-nvim;

        enabled = true;

        setupModule = "todo-comments";

        cmd = ["TodoTrouble"];

        keys = [
          (mkKeymap "n" "]t" ''function() require("todo-comments").jump_next() end'' {
            desc = "Next Todo Comment";
            lua = true;
            unique = true;
          })
          (mkKeymap "n" "[t" ''function() require("todo-comments").jump_prev() end'' {
            desc = "Previous Todo Comment";
            lua = true;
            unique = true;
          })
          (mkKeymap "n" "<leader>xt" "<cmd>Trouble todo toggle<cr>" {
            desc = "Todo (Trouble)";
            unique = true;
          })
          (mkKeymap "n" "<leader>xT" "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>" {
            desc = "Todo/Fix/Fixme (Trouble)";
            unique = true;
          })
          (mkKeymap "n" "<leader>st" ''function() require("todo-comments.fzf").todo() end'' {
            desc = "Todo";
            lua = true;
            unique = true;
          })
          (mkKeymap "n" "<leader>sT" ''function () require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME" } }) end'' {
            desc = "Todo/Fix/Fixme";
            lua = true;
            unique = true;
          })
        ];
      };
    };
  };
}
