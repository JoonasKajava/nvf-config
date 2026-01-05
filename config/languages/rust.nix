{lib, ...}: let
  inherit (lib.nvim.lua) toLuaObject;
in {
  vim.languages.rust = {
    enable = true;
    extensions.crates-nvim.enable = true;
    # TODO: Crates options might be incomplete
    dap.enable = true;

    lsp.opts = toLuaObject {
      rust-analyzer = {
        cargo = {
          allFeatures = true;
          loadOutDirsFromCheck = true;
          buildScripts = {
            enable = true;
          };
        };
        # Add clippy lints for Rust if using rust-analyzer
        checkOnSave = true;
        # Enable diagnostics if using rust-analyzer
        diagnostics = {
          enable = true;
        };
        procMacro = {
          enable = true;
          ignored = {
            async-trait = ["async_trait"];
            napi-derive = ["napi"];
            async-recursion = ["async_recursion"];
          };
        };
        files = {
          excludeDirs = [
            ".direnv"
            ".git"
            ".github"
            ".gitlab"
            "bin"
            "node_modules"
            "target"
            "venv"
            ".venv"
          ];
        };
      };
    };
  };
}

