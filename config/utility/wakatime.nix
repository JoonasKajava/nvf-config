{pkgs, ...}: {
  config = {
    vim.lazy.plugins = {
      "vim-wakatime" = {
        package = pkgs.vimPlugins.vim-wakatime;

        enabled = true;

        lazy = false;
      };
    };
  };
}
