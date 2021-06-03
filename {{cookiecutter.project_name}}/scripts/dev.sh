#! /usr/bin/env nix-shell
#! nix-shell -i bash ../shell.nix

ghcid -c "cabal repl -fdevelop" -T ":!cabal test -fdevelop"