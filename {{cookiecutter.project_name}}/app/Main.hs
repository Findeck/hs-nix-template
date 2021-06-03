module Main (main) where

import Import
import {{cookiecutter.module}}

main :: IO ()
main =
  print $ "Hello from " ++ do{{cookiecutter.module}} ++ "!"
