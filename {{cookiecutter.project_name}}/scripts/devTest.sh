#! /usr/bin/env nix-shell
#! nix-shell -i bash ../shell.nix

ghcid -c "cabal repl -fdevelop {{cookiecutter.project_name}}-tests" -T ":!cabal test -fdevelop"