{lib, ...}: let
  inherit (lib.nvim.dag) entryBefore;
  inherit (lib.nvim.lua) toLuaObject;

  icons = import ./icons.nix;
in {
  imports = [
    ./ui
    ./editor
    ./general.nix
    ./keymaps.nix
    ./languages
    ./autocmds
    ./mini
    ./coding
    ./theme
    ./utility
    ./autocomplete
    ./assistant
    ./snippets
  ];

  vim.luaConfigRC.icons =
    entryBefore ["globalsScript"]
    ''
      nvf_icons = ${toLuaObject icons}
    '';
}
