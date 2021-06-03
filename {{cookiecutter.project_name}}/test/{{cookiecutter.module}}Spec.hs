module {{cookiecutter.module}}Spec (spec) where

import Import
import Test.Hspec
import Test.Hspec.QuickCheck
import {{cookiecutter.module}}

spec :: Spec
spec = do
  describe "do{{cookiecutter.module}}" $ do
    it "does {{cookiecutter.module}} correctly" $
      do{{cookiecutter.module}} `shouldBe` "{{cookiecutter.module}}"
    prop "does {{cookiecutter.module}} always correctly" $
      \() -> do{{cookiecutter.module}} `shouldBe` "{{cookiecutter.module}}"