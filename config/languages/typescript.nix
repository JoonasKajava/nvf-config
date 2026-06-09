{config, ...}: {
  vim.languages.typescript = {
    enable = true;
    #lsp.servers = ["denols"];
    extensions.ts-error-translator.enable = true;
  };
}
