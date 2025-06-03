{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryBefore;
  inherit (lib.strings) concatStringsSep;
in {
  vim.extraPackages = with pkgs; [wl-clipboard];
  vim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
      # Fix markdown indentation settings
      markdown_recommended_style = 0;
      ai_cmp = true;
    };
    options = {
      clipboard =
        mkLuaInline
        /*
        Lua
        */
        ''vim.env.SSH_TTY and "" or "unnamedplus"'';
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      foldlevel = 99;
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true;
      inccommand = "nosplit";
      jumpoptions = "view";
      laststatus = 3;
      linebreak = true;
      list = true;

      mouse = "a";
      number = true;
      pumblend = 10;
      pumheight = 10;
      relativenumber = true;
      ruler = false;
      scrolloff = 4;
      sessionoptions = concatStringsSep "," ["buffers" "curdir" "tabpages" "winsize" "help" "globals" "skiprtp" "folds"];
      shiftround = true;
      shiftwidth = 2;
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      spelllang = "en";
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      #statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
      tabstop = 2; # Number of spaces tabs count for
      termguicolors = true; # True color support
      timeoutlen = 10000;
      undofile = true;
      undolevels = 10000;
      updatetime = 200; # Save swap file and trigger CursorHold
      virtualedit = "block"; # Allow cursor to move where there is no text in visual block mode
      wildmode = "longest:full,full"; # Command-line completion mode
      winminwidth = 5; # Minimum window width
      wrap = false; # Disable line wrap
      # TODO: Fold stuff
    };
    luaConfigRC.myGeneralExtras =
      entryBefore ["optionsScript"]
      /*
      lua
      */
      ''
        vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
        vim.opt.fillchars = {
              foldopen = "",
              foldclose = "",
              fold = " ",
              foldsep = " ",
              diff = "╱",
              eob = " "
        }
      '';
  };
}
