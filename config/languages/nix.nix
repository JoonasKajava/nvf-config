{
  vim.languages.nix = {
    enable = true;
    lsp = {
      server = "nixd";
      options = {
        # TODO: add nixd options
      };
    };
  };
}
