{lib, ...}: let
  inherit (lib) mkForce;
in {
  den.aspects.nvf = {
    vim = {pkgs, ...}: {
      assistant.copilot = {
        enable = true;
        cmp.enable = mkForce false; # This only works with nvim-cmp and I use blink

        setupOpts = {
          panel.enabled = mkForce false; # Handled by blink.
          suggestion.enabled = mkForce false; # Handled by blink.
        };
        # TODO: add ai_accept function
      };

      lazy.plugins.copilot-lua.keys = mkForce []; # Remove all default keymaps

      autocomplete.blink-cmp = {
        setupOpts.sources.providers.copilot.async = true;
        sourcePlugins = {
          copilot = {
            enable = true;
            package = pkgs.vimPlugins.blink-cmp-copilot;
            module = "blink-cmp-copilot";
          };
        };
      };
    };
  };
}
