Feature: String to Boolean Conversion

  Scenario: Convert string "tru" to boolean
    Given the string "tru"
    When the string is converted to boolean
    Then the result should be false
