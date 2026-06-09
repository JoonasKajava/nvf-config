{config, ...}: {
  vim.languages.typescript = {
    enable = true;
    #lsp.servers = ["denols"];
    # TODO: Disable for now
    # extensions.ts-error-translator.enable = true;
  };
}
