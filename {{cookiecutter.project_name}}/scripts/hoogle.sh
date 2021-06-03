#! /usr/bin/env nix-shell
#! nix-shell -i bash ../shell.nix

hoogle server --local -p ${1:-3000} -n