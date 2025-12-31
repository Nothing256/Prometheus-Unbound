Feature: Phonetic Engine Backward Compatibility

  Background:
    Given I have a PhoneticEngine with NameType "GENERIC", RuleType "APPROX" and concat "true"

  Scenario: Encoding "Bendzin" should preserve all original variations
    When I encode the string "Bendzin"
    Then the result should be "bndzn|bntsn|bnzn|vndzn|vntsn"
