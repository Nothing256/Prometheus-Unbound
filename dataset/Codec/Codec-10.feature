Feature: Caverphone 2.0 Algorithm

  The Caverphone 2.0 algorithm should correctly handle the "mb" letter combination
  at the end of a word, treating it as a single "m" sound.

  Scenario: Word ending with "mb"
    Given the input string is "mb"
    When I encode the string using Caverphone 2.0
    Then the encoded result should be "M111111111"

  Scenario: Word with "mb" at the beginning and end
    Given the input string is "mbmb"
    When I encode the string using Caverphone 2.0
    Then the encoded result should be "MPM1111111"
