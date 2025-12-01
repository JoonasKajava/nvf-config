{
  vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;
      enableDAP = true;
    };
    lsp.enable = true;
  };

  # TODO: Maybe better lsp config options

  imports = [
    ./bash.nix
    ./clang.nix
    ./csharp.nix
    ./go.nix
    ./html.nix
    ./lua.nix
    ./markdown.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
    ./sql.nix
    ./svelte.nix
    ./tailwind.nix
    ./ts.nix
    ./yaml.nix
    ./nu.nix
    ./otter-nvim.nix
    ./json.nix
  ];
}
