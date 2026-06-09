{
  config,
  lib,
  ...
}: let
  cfg = config.vim.lsp.presets.tailwindcss-language-server;
in {
  config.vim = {
    lsp = {
      presets.tailwindcss-language-server.enable = true;

      servers.tailwindcss = lib.mkIf cfg.enable {
        filetypes = ["rust"];
        settings.tailwindCSS = {
          experimental.classRegex = [''class: "(.*)"''];
          includeLanguages.rust = "html";
        };
      };
    };
  };
}
