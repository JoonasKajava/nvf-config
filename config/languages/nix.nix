{
  lib,
  config,
  typenix,
  system,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.generators) mkLuaInline;
  inherit (lib.nvim.dag) entryAfter;

  cfg = config.vim.languages.nix;
in {
  vim = {
    languages.nix = {
      enable = true;
      lsp.enable = false;
    };
    lsp.servers.typenix = {
      cmd =
        mkLuaInline #lua
        
        ''
          function(dispatchers)
          	local cmd = "${lib.getExe typenix.packages.${system}.typenix}"
          	return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
          	end
        '';
      root_markers = ["flake.nix" ".git"];
      filetypes = ["nix" "nixts"];
    };

    luaConfigRC.typenixExtras =
      entryAfter ["lsp-servers"]
      /*
      lua
      */
      ''
        vim.filetype.add({
        	pattern = {
        		[".*/*.nix.d.ts"] = "nixts",
        	},
        })
        vim.treesitter.language.register("typescript", { "nixts" })
      '';
  };
}
