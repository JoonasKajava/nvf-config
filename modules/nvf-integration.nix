{
  den,
  lib,
  inputs,
  ...
}: {
  flake-file.inputs = {
    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  den.lib.nvf.package = pkgs: vimAspect: ctx:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [(den.lib.nvf.module vimAspect ctx)];
    }).neovim;

  den.lib.nvf.module = vimAspect: ctx: let
    # Wrap each `vim` class module so its value lands under nvf's `vim` option.
    # Forwarding into `intoPath = ["vim"]` (with adaptArgs) goes through den's
    # freeform adapter (`lazyAttrsOf unspecified`), which merges attrsets
    # shallowly: e.g. every `lazy.plugins` definition overwrote the others.
    # Importing at top level lets nvf's own option types do the merging.
    nestUnderVim = node:
      if builtins.isAttrs node && node ? imports
      then node // {imports = map nestUnderVim node.imports;}
      else if lib.isFunction node
      then lib.mirrorFunctionArgs node (args: {vim = node args;})
      else {vim = node;};

    # a custom `vim` class that forwards to `nvf.vim`
    vimClass = {
      class,
      aspect-chain,
    }:
      den.batteries.forward {
        each = lib.singleton true;
        fromClass = _: "vim";
        intoClass = _: "nvf";
        intoPath = _: [];
        mapModule = _: nestUnderVim;
        fromAspect = _: lib.head aspect-chain;
      };

    aspect = {
      includes = [
        vimClass
        vimAspect
      ];
      # Maybe needed
      #__scopeHandlers = den.lib.aspects.fx.handlers.constantHandler ctx;
    };

    module = den.lib.aspects.resolve "nvf" aspect;
  in
    module;
}
