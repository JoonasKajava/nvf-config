{config, lib, ...}: let
  cfg = config.vim.languages.tailwind;
in {
  config.vim = {
    languages.tailwind = {
      enable = true;
    };

    lsp.servers.tailwindcss = lib.mkIf cfg.enable {
      filetypes = ["rust"];
      settings.tailwindCSS = {
        experimental.classRegex = [''class: "(.*)"''];
        includeLanguages.rust = "html";
      };
    };
  };
}
