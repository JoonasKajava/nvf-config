{
  # TODO: Maybe replace with alpha-nvim
  # Or with snacks
  vim.dashboard.dashboard-nvim = {
    enable = false;
    setupOpts = {
      theme = "doom";
      hide = {
        statusline = false;
      };
      config = {
        # TODO: Add some padding
        week_header = {
          enable = true;
        };
        center = [
          {
            action = ":Telescope find_files"; # TODO: Replace with fzf-lua
            desc = " Find File";
            icon = " ";
            key = "f";
          }
          {
            action = "ene | startinsert";
            desc = " New File";
            icon = " ";
            key = "n";
          }
          {
            action = ":Telescope oldfiles";
            desc = " Recent Files";
            icon = " ";
            key = "r";
          }
          {
            action = ":Telescope live_grep";
            desc = " Find Text";
            icon = " ";
            key = "g";
          }
          {
            action = ":qa";
            desc = " Quit";
            icon = " ";
            key = "q";
          }
        ];

        vertical_center = true;
      };
    };
  };
}
