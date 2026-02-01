{...}: {
  config = {
    vim.utility.smart-splits = {
      enable = true;
      keymaps = {
        move_cursor_left = "<c-h>";
        move_cursor_right = "<c-l>";
        move_cursor_down = "<c-j>";
        move_cursor_up = "<c-l>";
      };
    };
  };
}
