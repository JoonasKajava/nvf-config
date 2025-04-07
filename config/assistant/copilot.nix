{
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkForce;
in {
  vim.assistant.copilot = {
    enable = true;
    cmp.enable = mkForce false; # This only works with nvim-cmp and I use blink

    setupOpts = {
      panel.enabled = mkForce false; # Handled by blink.
      suggestion.enabled = mkForce false; # Handled by blink.
    };
    # TODO: add ai_accept function
  };

  vim.lazy.plugins.copilot-lua.keys = mkForce []; # Remove all default keymaps

  vim.autocomplete.blink-cmp = {
    setupOpts.sources.providers.copilot.async = true;
    sourcePlugins = {
      copilot = {
        enable = true;
        package = pkgs.vimPlugins.blink-cmp-copilot;
        module = "blink-cmp-copilot";
      };
    };
  };
}
