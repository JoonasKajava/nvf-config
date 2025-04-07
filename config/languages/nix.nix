{
  vim.languages.nix = {
    enable = true;
    lsp = {
      #server = "nixd"; use nil_ls for now
      options = {
        # TODO: add nixd options
      };
    };
  };
}
