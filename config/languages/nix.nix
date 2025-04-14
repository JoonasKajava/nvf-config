{lib, ...}: let
  inherit (lib.nvim.dag) entryBefore;
  inherit (lib) mkIf;
  use-nixd = false;
in {
  vim.languages.nix = {
    enable = true;

    lsp = {
      server = mkIf use-nixd "nixd";
      options = {
      };
    };
  };

  vim.luaConfigRC = mkIf use-nixd {
    find-flake-func =
      entryBefore ["nix-lsp"]
      /*
      lua
      */
      ''
        function find_root_flake()
          local flake_root = vim.fs.root(0, "flake.nix")
          return flake_root
        end
      '';
  };
}
