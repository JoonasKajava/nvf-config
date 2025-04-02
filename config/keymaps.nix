{lib, ...}: let
  inherit (lib.nvim.binds) mkKeymap;
  inherit (lib.nvim.dag) entryBefore;
in {
  vim.keymaps = [
    # Better up/down
    (mkKeymap ["n" "x"] "j" "v:count == 0 ? 'gj' : 'j'" {
      desc = "Down";
      expr = true;
      silent = true;
    })
    (mkKeymap ["n" "x"] "<Down>" "v:count == 0 ? 'gj' : 'j'" {
      desc = "Down";
      expr = true;
      silent = true;
    })
    (mkKeymap ["n" "x"] "k" "v:count == 0 ? 'gk' : 'k'" {
      desc = "Up";
      expr = true;
      silent = true;
    })
    (mkKeymap ["n" "x"] "<Up>" "v:count == 0 ? 'gk' : 'k'" {
      desc = "Up";
      expr = true;
      silent = true;
    })

    # Move to window using the <ctrl> hjkl keys
    (mkKeymap "n" "<C-h>" "<C-w>h" {
      desc = "Go to Left Window";
      noremap = false;
    })
    (mkKeymap "n" "<C-j>" "<C-w>j" {
      desc = "Go to Lower Window";
      noremap = false;
    })
    (mkKeymap "n" "<C-k>" "<C-w>k" {
      desc = "Go to Upper Window";
      noremap = false;
    })
    (mkKeymap "n" "<C-l>" "<C-w>l" {
      desc = "Go to Right Window";
      noremap = false;
    })

    # Resize window using <ctrl> arrow keys
    (mkKeymap "n" "<C-Up>" "<cmd>resize +2<cr>" {desc = "Increase Window Height";})
    (mkKeymap "n" "<C-Down>" "<cmd>resize -2<cr>" {desc = "Decrease Window Height";})
    (mkKeymap "n" "<C-Left>" "<cmd>vertical resize -2<cr>" {desc = "Decrease Window Width";})
    (mkKeymap "n" "<C-Right>" "<cmd>vertical resize +2<cr>" {desc = "Increase Window Width";})

    # Move Lines
    (mkKeymap "n" "<A-j>" "<cmd>execute 'move .+' . v:count1<cr>==" {desc = "Move Down";})
    (mkKeymap "n" "<A-k>" "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==" {desc = "Move Up";})
    (mkKeymap "i" "<A-j>" "<esc><cmd>m .+1<cr>==gi" {desc = "Move Down";})
    (mkKeymap "i" "<A-k>" "<esc><cmd>m .-2<cr>==gi" {desc = "Move Up";})
    (mkKeymap "v" "<A-j>" ":<C-u>execute \"'<'>move '>+\" . v:count1<cr>gv=gv" {desc = "Move Down";})
    (mkKeymap "v" "<A-k>" ":<C-u>execute \"'<'>move '<-\" . (v:count1 + 1)<cr>gv=gv" {desc = "Move Up";})

    # buffers
    (mkKeymap "n" "<S-h>" "<cmd>bprevious<cr>" {desc = "Prev Buffer";})
    (mkKeymap "n" "<S-l>" "<cmd>bnext<cr>" {desc = "Next Buffer";})
    (mkKeymap "n" "[b" "<cmd>bprevious<cr>" {desc = "Prev Buffer";})
    (mkKeymap "n" "]b" "<cmd>bnext<cr>" {desc = "Next Buffer";})
    (mkKeymap "n" "<leader>bb" "<cmd>e #<cr>" {desc = "Switch to Other Buffer";})
    (mkKeymap "n" "<leader>`" "<cmd>e #<cr>" {desc = "Switch to Other Buffer";})
    (mkKeymap "n" "<leader>bd" "TODO: Snack.bufdelete()" {desc = "Delete Buffer";})
    (mkKeymap "n" "<leader>bo" "TODO: Snacks.bufdelete.other()" {desc = "Delete Other Buffers";})
    (mkKeymap "n" "<leader>bD" "<cmd>:bd<cr>" {desc = "Delete Buffer and Window";})

    # Clear search and stop snippet on escape
    (mkKeymap ["i" "n" "s"] "<esc>"
      /*
      lua
      */
      ''
        function()
          vim.cmd("noh")
          -- LazyVim.cmp.actions.snippet_stop() TODO: replace this with something else
          return "<esc>"
        end
      '' {
        #expr = true;
        lua = true;
        desc = "Escape and Clear hlsearch";
      })

    # Clear search, diff update and redraw
    (mkKeymap
      "n"
      "<leader>ur"
      "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>"
      {desc = "Redraw / Clear hlsearch / Diff Update";})

    # https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
    (mkKeymap "n" "n" "'Nn'[v:searchforward].'zv'" {
      expr = true;
      desc = "Next Search Result";
    })
    (mkKeymap "x" "n" "'Nn'[v:searchforward]" {
      expr = true;
      desc = "Next Search Result";
    })
    (mkKeymap "o" "n" "'Nn'[v:searchforward]" {
      expr = true;
      desc = "Next Search Result";
    })
    (mkKeymap "n" "N" "'nN'[v:searchforward].'zv'" {
      expr = true;
      desc = "Prev Search Result";
    })
    (mkKeymap "x" "N" "'nN'[v:searchforward]" {
      expr = true;
      desc = "Prev Search Result";
    })
    (mkKeymap "o" "N" "'nN'[v:searchforward]" {
      expr = true;
      desc = "Prev Search Result";
    })

    # Add undo break-points
    (mkKeymap "i" "" "<c-g>u" {})
    (mkKeymap "i" "." ".<c-g>u" {})
    (mkKeymap "i" ";" ";<c-g>u" {})

    # save file
    (mkKeymap ["i" "x" "n" "s"] "<C-s>" "<cmd>w<cr><esc>" {desc = "Save File";})

    # keywordprg
    (mkKeymap "n" "<leader>K" "<cmd>norm! K<cr>" {desc = "Keywordprg";})

    # better indenting
    (mkKeymap "v" "<" "<gv" {})
    (mkKeymap "v" ">" ">gv" {})

    # commenting
    (mkKeymap "n" "gco" "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>" {desc = "Add Comment Below";})
    (mkKeymap "n" "gcO" "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>" {desc = "Add Comment Above";})

    # Location list?
    # Quicfix list?

    # formatting
    (mkKeymap ["n" "v"] "<leader>cf"
      /*
      lua
      */
      ''
        function()
          -- TODO: replace this with something else
          -- LazyVim.format({ force = true })
        end
      '' {desc = "Format";})

    # diagnostic
    (mkKeymap "n" "<leader>cd" "vim.diagnostic.open_float" {
      desc = "Line Diagnostics";
      lua = true;
    })
    (mkKeymap "n" "]d" "diagnostic_goto(true)" {
      desc = "Next Diagnostic";
      lua = true;
    })
    (mkKeymap "n" "[d" "diagnostic_goto(false)" {
      desc = "Prev Diagnostic";
      lua = true;
    })
    (mkKeymap "n" "]e" "diagnostic_goto(true \"ERROR\")" {
      desc = "Next Error";
      lua = true;
    })
    (mkKeymap "n" "[e" "diagnostic_goto(false \"ERROR\")" {
      desc = "Prev Error";
      lua = true;
    })
    (mkKeymap "n" "]w" "diagnostic_goto(true \"WARN\")" {
      desc = "Next Warning";
      lua = true;
    })
    (mkKeymap "n" "[w" "diagnostic_goto(false \"WARN\")" {
      desc = "Prev Warning";
      lua = true;
    })
    # TODO: Toggle options?

    # TODO: Lazygit

    # quit
    (mkKeymap "n" "<leader>qq" "<cmd>qa<cr>" {desc = "Quit All";})

    # highlights under cursor
    (mkKeymap "n" "<leader>ui" "vim.show_pos" {
      desc = "Inspect Pos";
      lua = true;
    })
    (mkKeymap "n" "<leader>uI"
      /*
      lua
      */
      ''function() vim.treesitter.inspect_tree() vim.api.nvim_input("I") end'' {
        desc = "Inspect Tree";
        lua = true;
      })

    # windows
    (mkKeymap "n" "<leader>-" "<C-W>s" {
      desc = "Split Window Below";
      noremap = false;
    })
    (mkKeymap "n" "<leader>|" "<C-W>v" {
      desc = "Split Window Right";
      noremap = false;
    })
    (mkKeymap "n" "<leader>wd" "<C-W>c" {
      desc = "Delete Window";
      noremap = false;
    })
    # TODO: These
    #Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
    #Snacks.toggle.zen():map("<leader>uz")

    # tabs
    (mkKeymap "n" "<leader><tab>l" "<cmd>tablast<cr>" {desc = "Last Tab";})
    (mkKeymap "n" "<leader><tab>o" "<cmd>tabonly<cr>" {desc = "Close Other Tabs";})
    (mkKeymap "n" "<leader><tab>f" "<cmd>tabfirst<cr>" {desc = "First Tab";})
    (mkKeymap "n" "<leader><tab><tab>" "<cmd>tabnew<cr>" {desc = "New Tab";})
    (mkKeymap "n" "<leader><tab>]" "<cmd>tabnext<cr>" {desc = "Next Tab";})
    (mkKeymap "n" "<leader><tab>d" "<cmd>tabclose<cr>" {desc = "Close Tab";})
    (mkKeymap "n" "<leader><tab>[" "<cmd>tabprevious<cr>" {desc = "Previous Tab";})
  ];

  vim.luaConfigRC.functionsForMappings =
    entryBefore ["mappings"]
    /*
    lua
    */
    ''
      local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
          go({ severity = severity })
        end
      end
    '';
}
