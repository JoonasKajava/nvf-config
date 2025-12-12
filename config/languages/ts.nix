{config, ...}: {
  vim.languages.ts = {
    enable = true;
    #lsp.servers = ["denols"];
    extensions.ts-error-translator.enable = true;
  };
}
