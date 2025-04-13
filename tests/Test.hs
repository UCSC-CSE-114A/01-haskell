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
      7.5
      "reverse 1"
  , mkTest
      listReverse
      ["a", "b", "c", "d"]
      ["d", "c", "b", "a"]
      7.5
      "reverse 2"
  , mkTest
      listReverse
      ([] :: [Integer])
      []
      5
      "reverse 3"

  , mkTest
      palindrome
      "malayalam"
      True
      5
      "palindrome 1"
  , mkTest
      palindrome
      "palindrome"
      False
      5
      "palindrome 2"
  , mkTest
      palindrome
      ""
      True
      5
      "palindrome 3"

  , mkTest
      digitsOfInt
      3124
      [3, 1, 2, 4]
      5
      "digitsOfInt 1"
  , mkTest
      digitsOfInt
      352663
      [3, 5, 2, 6, 6, 3]
      5
      "digitsOfInt 2"
  , mkTest
      digitsOfInt
      (-42)
      []
      2
      "digitsOfInt 3"

  , mkTest
      digitsOfInts
      [3124, 52, -42, 8]
      [3, 1, 2, 4, 5, 2, 8]
      2.5
      "digitsOfInts 1"
  , mkTest
      digitsOfInts
      []
      []
      2.5
      "digitsOfInts 2"

  , mkTest
      doubleEveryOther
      [8,7,6,5]
      [8,14,6,10]
      5
      "doubleEveryOther 1"
  , mkTest
      doubleEveryOther
      [1,2,3]
      [1,4,3]
      5
      "doubleEveryOther 2"
  , mkTest
      doubleEveryOther
      []
      []
      5
      "doubleEveryOther 3"

  , mkTest
      sumList
      []
      0
      2.5
      "sumList 1"
  , mkTest
      sumList
      [1, 2, 3, 4]
      10
      2.5
      "sumList 2"
  , mkTest
      sumList
      [1, -2, 3, 5]
      7
      2.5
      "sumList 3"
  , mkTest
      sumList
      [1, 3, 5, 7, 9, 11]
      36
      2.5
      "sumList 4"

  , mkTest
      validateCardNumber
      4012888888881881
      True
      10
      "validateCardNumber 1"
  , mkTest
      validateCardNumber
      4012888888881882
      False
      10
      "validateCardNumber 2"
  ]
  where
    mkTest :: (Show b, Eq b) => (a -> b) -> a -> b -> Double -> String -> TestTree
    mkTest = scoreTest' sc
