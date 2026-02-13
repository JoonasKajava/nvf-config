{
  vim.utility.snacks-nvim.setupOpts.dashboard = {
    enabled = true;

    sections = [
      {section = "header";}
      {
        section = "keys";
        gap = 1;
        padding = 1;
      }
    ];

    preset.keys = [
      {
        action = "<cmd>FzfLua files<cr>";
        desc = " Find File";
        icon = " ";
        key = "f";
      }
      {
        action = "<cmd>FzfLua live_grep<cr>";
        desc = " Find Text";
        icon = " ";
        key = "g";
      }
      {
        action = "ene | startinsert";
        desc = " New File";
        icon = " ";
        key = "n";
      }
      {
        action = ":lua Snacks.dashboard.pick('oldfiles')";
        desc = " Recent Files";
        icon = " ";
        key = "r";
      }
      {
        action = ":qa";
        desc = " Quit";
        icon = " ";
        key = "q";
      }
    ];
  };
}
