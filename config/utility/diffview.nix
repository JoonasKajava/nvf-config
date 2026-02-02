{
  config,
  lib,
  ...
}: {
  config = {
    # TODO: Finish keybinds and settings
    vim.utility.diffview-nvim = {
      enable = false;
      setupOpts = {
      };
    };

    vim.keymaps = lib.mkIf config.vim.utility.diffview-nvim.enable [
      {
        key = "<leader>gc";
        mode = ["n"];
        action = "<cmd>DiffviewFileHistory<cr>";
        desc = "Commits";
        unique = true;
      }
      {
        key = "<leader>gb";
        mode = ["n"];
        action = "<cmd>DiffviewFileHistory %<cr>";
        desc = "Buffer Commits";
        unique = true;
      }
      {
        key = "<leader>gq";
        mode = ["n"];
        action = "<cmd>DiffviewClose<cr>";
        desc = "Close Diffview";
        unique = true;
      }
    ];
  };
}
