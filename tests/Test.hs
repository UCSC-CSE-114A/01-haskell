import Test.Tasty
import Common
import Hw1

main :: IO ()
main = runTests [unit1]

unit1 :: Score -> TestTree
unit1 sc = testGroup "Unit 1"
  [ mkTest
      listReverse
      [1, 2, 3, 4]
      [4, 3, 2, 1]
      "reverse 1"
  , mkTest
      listReverse
      ["a", "b", "c", "d"]
      ["d", "c", "b", "a"]
      "reverse 2"
  , mkTest
      listReverse
      ([] :: [Integer])
      []
      "reverse 3"

  , mkTest
      palindrome
      "malayalam"
      True
      "palindrome 1"
  , mkTest
      palindrome
      "palindrome"
      False
      "palindrome 2"
  , mkTest
      palindrome
      ""
      True
      "palindrome 3"

  , mkTest
      digitsOfInt
      3124
      [3, 1, 2, 4]
      "digitsOfInt 1"
  , mkTest
      digitsOfInt
      352663
      [3, 5, 2, 6, 6, 3]
      "digitsOfInt 2"
  , mkTest
      digitsOfInt
      (-42)
      []
      "digitsOfInt 3"

  , mkTest
      digitsOfInts
      [3124, 52, -42, 8]
      [3, 1, 2, 4, 5, 2, 8]
      "digitsOfInts 1"
  , mkTest
      digitsOfInts
      []
      []
      "digitsOfInts 2"

  , mkTest
      doubleEveryOther
      [8,7,6,5]
      [8,14,6,10]
      "doubleEveryOther 1"
  , mkTest
      doubleEveryOther
      [1,2,3]
      [1,4,3]
      "doubleEveryOther 2"
  , mkTest
      doubleEveryOther
      []
      []
      "doubleEveryOther 3"

  , mkTest
      sumList
      []
      0
      "sumList 1"
  , mkTest
      sumList
      [1, 2, 3, 4]
      10
      "sumList 2"
  , mkTest
      sumList
      [1, -2, 3, 5]
      7
      "sumList 3"
  , mkTest
      sumList
      [1, 3, 5, 7, 9, 11]
      36
      "sumList 4"

  , mkTest
      validateCardNumber
      4012888888881881
      True
      "validateCardNumber 1"
  , mkTest
      validateCardNumber
      4012888888881882
      False
      "validateCardNumber 2"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> b) -> a -> b -> String -> TestTree
    mkTest = mkTest' sc
