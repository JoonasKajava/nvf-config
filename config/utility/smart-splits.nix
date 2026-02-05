{...}: {
  config = {
    vim.utility.smart-splits = {
      enable = true;
      keymaps = {
        move_cursor_left = "<c-h>";
        move_cursor_right = "<c-l>";
        move_cursor_down = "<c-j>";
        move_cursor_up = "<c-l>";

        # TODO: Find better keymaps for these
        swap_buf_left = null;
        swap_buf_right = null;
        swap_buf_up = null;
        swap_buf_down = null;
      };
    };
  };
}
