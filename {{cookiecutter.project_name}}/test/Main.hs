module Main (main) where

import Import
import Test.Hspec
import qualified {{cookiecutter.module}}Spec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  context "{{cookiecutter.module}}" {{cookiecutter.module}}Spec.spec