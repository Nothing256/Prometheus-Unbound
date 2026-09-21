Feature: String to boolean conversion

  Scenario Outline: Convert non-matching strings to boolean
    Given the string "<input>"
    When the string is converted to boolean
    Then the result should be false

    Examples:
      | input |
      | tru   |
      | TRU   |
