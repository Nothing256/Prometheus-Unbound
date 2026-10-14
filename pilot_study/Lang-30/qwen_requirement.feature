Feature: StringUtils.containsNone with supplementary characters
  The containsNone method should correctly handle supplementary Unicode characters
  which are represented as surrogate pairs in Java (two char values: high and low surrogates)

  Scenario: Check if string with supplementary characters contains any of the search characters
    Given a string containing supplementary character U+20000 (\uD840\uDC00)
    When checking if it contains the supplementary character U+20000
    Then the method should return false because the string does contain the character

  Scenario: Check if string with supplementary character contains different supplementary character
    Given a string containing supplementary character U+20000 (\uD840\uDC00)
    When checking if it contains a different supplementary character U+20001 (\uD840\uDC01)
    Then the method should return true because the string does not contain the different character

  Scenario: Check if string with multiple supplementary characters contains any of the search characters
    Given a string containing supplementary characters U+20000 followed by U+20001 (\uD840\uDC00\uD840\uDC01)
    When checking if it contains the supplementary character U+20000
    Then the method should return false because the string does contain the character

  Scenario: Check if string with supplementary character contains any of the search character array
    Given a string containing supplementary character U+20000 (\uD840\uDC00) 
    When checking if it contains any of the characters in array ['\uD840', '\uDC00'] (surrogate pair components)
    Then the method should return false because the string does contain the surrogate pair components

  Scenario: Check if string with supplementary character U+20000 does not contain supplementary character U+20001
    Given a string containing supplementary character U+20000 (\uD840\uDC00)
    When checking if it contains the supplementary character U+20001 (\uD840\uDC01)
    Then the method should return true because the string does not contain the different supplementary character