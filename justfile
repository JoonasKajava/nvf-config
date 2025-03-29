run:
    nix run .
check:
    nix flake check --all-systems
lua:
    nix build && ./result/bin/nvf-print-config | vim -c 'set filetype=lua'
