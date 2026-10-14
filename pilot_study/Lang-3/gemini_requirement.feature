Feature: Number Creation from String

  The NumberUtils.createNumber method should convert a string representation of a number
  into the most appropriate Java Number type (Float, Double, BigDecimal, etc.) ensuring
  that the value is represented with minimal precision loss and correct magnitude.

  Scenario: Create a number that fits in Float without precision loss
    Given the string "1.23"
    When I create a number from the string
    Then the result should be an instance of Float
    And the result value should be approximately 1.23

  Scenario: Create a number that exceeds Float precision but fits in Double
    # This scenario addresses the bug where "3.40282354e+38" was incorrectly returned as a Float (Infinity or truncated)
    # instead of a Double, causing precision loss.
    Given the string "3.40282354e+38"
    When I create a number from the string
    Then the result should be an instance of Double
    And the result value should be approximately 3.40282354e+38

  Scenario: Create a number that exceeds Double precision
    Given the string "1.797693134862315759e+308"
    When I create a number from the string
    Then the result should be an instance of BigDecimal
    And the result value should match the input string value

