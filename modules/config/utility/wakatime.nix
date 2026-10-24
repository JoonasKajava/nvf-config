{
  den.aspects.nvf = {
    vim = {pkgs, ...}: {
      lazy.plugins = {
        "vim-wakatime" = {
          package = pkgs.vimPlugins.vim-wakatime;

          enabled = true;

          lazy = false;
        };
      };
    };
  };
}
