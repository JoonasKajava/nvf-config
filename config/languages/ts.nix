{config, ...}: {
  vim.languages.ts = {
    enable = true;
    extensions.ts-error-translator.enable = true;
  };
  vim.formatter.conform-nvim = {
    setupOpts = {
      formatters_by_ft.javascript = [config.vim.languages.ts.format.type];
    };
  };
}
