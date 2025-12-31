Feature: CSV Lexer Escape Sequence Handling

  As a developer using the CSV parser
  I want the lexer to preserve undefined escape sequences as literal characters
  So that data containing backslashes followed by non-special characters (like MySQL NULL '\N') is parsed correctly

  Scenario: Lexer preserves undefined escape sequences
    Given I have a CSV lexer configured with escape character '\'
    When I tokenize the input string "character\NEscaped"
    Then the generated token content should be "character\NEscaped"

  Scenario: Lexer preserves undefined escape sequences for alphanumeric characters
    Given I have a CSV lexer configured with escape character '\'
    When I tokenize the input string "character\aEscaped"
    Then the generated token content should be "character\aEscaped"

