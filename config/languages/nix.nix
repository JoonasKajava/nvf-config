{
  lib,
  config,
  ...
}: let
  inherit (lib.nvim.dag) entryBefore;
  inherit (lib.nvim.dag) entryAfter;
  inherit (lib.lists) isList;
  inherit (lib.nvim.lua) expToLua toLuaObject;
  inherit (lib.strings) optionalString;
  inherit (lib) mkIf mkForce;
  use-nixd = false;

  cfg = config.vim.languages.nix;

  useFormat = "on_attach = default_on_attach";
  noFormat = "on_attach = attach_keymaps";
  packageToCmd = package: defaultCmd:
    if isList package
    then expToLua package
    else ''{"${package}/bin/${defaultCmd}"}'';

in {
  vim.languages.nix = {
    enable = true;

    lsp = {
      server = mkIf use-nixd "nixd";
      options = {
      };
    };
  };
  vim.lsp.lspconfig.sources.nix-lsp = mkForce ''
        lspconfig.nil_ls.setup{
          capabilities = capabilities,
        ${
          if cfg.format.enable
          then useFormat
          else noFormat
        },
          cmd = ${packageToCmd cfg.lsp.package "nil"},
        ${optionalString cfg.format.enable ''
          settings = {
            ["nil"] = {
            ["nix"] = {
              ["flake"] = {
                ["autoArchive"] = true,
                ["autoEvalInputs"] = true
              },
            },
          ${optionalString (cfg.format.type == "alejandra")
            ''
              formatting = {
                command = {"${cfg.format.package}/bin/alejandra", "--quiet"},
              },
            ''}
          ${optionalString (cfg.format.type == "nixfmt")
            ''
              formatting = {
                command = {"${cfg.format.package}/bin/nixfmt"},
              },
            ''}
            },
          },
        ''}
        }
      '';
  # vim.luaConfigRC = mkIf use-nixd {
  #   find-flake-func =
  #     entryBefore ["nix-lsp"]
  #     /*
  #     lua
  #     */
  #     ''
  #       function find_root_flake()
  #         local flake_root = vim.fs.root(0, "flake.nix")
  #         return flake_root
  #       end
  #     '';
  # };
}
