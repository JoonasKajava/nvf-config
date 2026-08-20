{
  den.aspects.nvf = {
    vim = {pkgs, ...}: {
      visuals.nvim-web-devicons.enable = true;

      lazy.plugins = {
        "dropbar.nvim" = {
          package = pkgs.vimPlugins.dropbar-nvim;

          enabled = true;

          lazy = false; # Lazy-loading is apparently done by the plugin itself

          setupModule = "dropbar";

          setupOpts = {
          };
        };
      };
    };
  };
}
