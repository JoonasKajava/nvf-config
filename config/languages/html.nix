{
  lib,
  ...
}: let
  inherit (lib.nvim.dag);
in {
  vim.languages.html = {
    enable = true;
  };
  # vim.luaConfigRC.html-lsp =
  #   entryAfter ["lspconfig"]
  #   /*
  #   lua
  #   */
  #   ''
  #     require("lspconfig").html.setup {
  #       cmd = {"${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server", "--stdio"},
  #     };
  #   '';
}
