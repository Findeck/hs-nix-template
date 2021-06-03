module Main (main) where

import Prelude
import {{cookiecutter.module}}

main :: IO ()
main =
  print $ "Hello from " ++ do{{cookiecutter.module}} ++ "!"
