Feature: NumberUtils.createNumber should preserve precision when selecting appropriate numeric type

  The NumberUtils.createNumber method should correctly identify which numeric type
  is most appropriate for a given string representation, ensuring no precision loss
  occurs when dealing with floating point numbers.

  Scenario: Creating a number from string "1.23" should return a Float
    Given a string "1.23"
    When NumberUtils.createNumber is called with this string
    Then the result should be an instance of Float

  Scenario: Creating a number from string "3.40282354e+38" should return a Double  
    Given a string "3.40282354e+38" (value that exceeds Float range but fits in Double)
    When NumberUtils.createNumber is called with this string
    Then the result should be an instance of Double

  Scenario: Creating a number from string "1.797693134862315759e+308" should return a BigDecimal
    Given a string "1.797693134862315759e+308" (value that exceeds Double range)
    When NumberUtils.createNumber is called with this string
    Then the result should be an instance of BigDecimal

  Scenario: Preserving precision when converting floating point numbers
    Given a floating point number string that fits within Float precision
    When NumberUtils.createNumber processes the string
    Then it should not incorrectly promote to a larger type due to precision checking error