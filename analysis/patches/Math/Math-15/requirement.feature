Feature: FastMath.pow correctness for large integer exponents

  Background:
    Given the FastMath library is used

  Scenario: Calculate power of negative base with large odd integer exponent (positive)
    Given a negative base x = -1.0
    And a large odd integer exponent y = 5000000000000001.0
    When I calculate FastMath.pow(x, y)
    Then the result should be -1.0
    And the result should be equal to Math.pow(x, y)

  Scenario: Calculate power of negative base with large odd integer exponent (negative)
    Given a negative base x = -1.0
    And a large odd integer exponent y = -5000000000000001.0
    When I calculate FastMath.pow(x, y)
    Then the result should be -1.0
    And the result should be equal to Math.pow(x, y)
