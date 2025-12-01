{
  pkgs,
  lib,
  ...
}: let
  enable = true;
  formatPackage = pkgs.writeShellApplication {
    name = "jsonfmt";
    runtimeInputs = [pkgs.jsonfmt];
    text = "jsonfmt -w -";
  };
  formatType = "jsonfmt";
in {
  vim = lib.mkIf enable {
    treesitter = {
      enable = true;
      grammars = [pkgs.vimPlugins.nvim-treesitter.builtGrammars.json];
    };
    lsp.servers.jsonls = {
      cmd = [(lib.meta.getExe pkgs.vscode-json-languageserver) "--stdio"];
      filetypes = ["json" "jsonc"];
      init_options = {provideFormatter = true;};
      root_markers = [".git"];
      settings = {
        json = {
          # Schemas https://www.schemastore.org
          schemas = [
            {
              fileMatch = ["package.json"];
              url = "https://json.schemastore.org/package.json";
            }
            {
              fileMatch = ["deno.json"];
              url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json";
            }
            {
              fileMatch = ["tsconfig*.json"];
              url = "https://json.schemastore.org/tsconfig.json";
            }
            {
              fileMatch = ["jsconfig*.json"];
              url = "https://www.schemastore.org/jsconfig.json";
            }
            {
              fileMatch = [
                ".prettierrc"
                ".prettierrc.json"
                "prettier.config.json"
              ];
              url = "https://json.schemastore.org/prettierrc.json";
            }
            {
              fileMatch = [".eslintrc" ".eslintrc.json"];
              url = "https://json.schemastore.org/eslintrc.json";
            }
            {
              fileMatch = [".babelrc" ".babelrc.json" "babel.config.json"];
              url = "https://json.schemastore.org/babelrc.json";
            }
            {
              fileMatch = ["lerna.json"];
              url = "https://json.schemastore.org/lerna.json";
            }
            {
              fileMatch = ["now.json" "vercel.json"];
              url = "https://json.schemastore.org/now.json";
            }
            {
              fileMatch = [
                ".stylelintrc"
                ".stylelintrc.json"
                "stylelint.config.json"
              ];
              url = "http://json.schemastore.org/stylelintrc.json";
            }
          ];
        };
      };
      formatter.conform-nvim = {
        enable = true;
        setupOpts.formatters_by_ft.json = [formatType];
        setupOpts.formatters.${formatType} = {
          command = lib.meta.getExe formatPackage;
        };
      };
    };
  };
}
