Feature: Hyperbolic functions accuracy for large arguments

  In order to perform accurate mathematical calculations with large numbers
  As a library user
  I want FastMath.cosh and FastMath.sinh to return finite results when the output is within Double range, even if intermediate exp(x) overflows

  Scenario: Calculate cosh for large positive value 710.0
    Given the input value is 710.0
    When I call FastMath.cosh with the input
    Then the result should be finite
    And the result should be approximately 1.1169973830808557E308
    And the result should match Math.cosh within 1 ULP

  Scenario: Calculate sinh for large positive value 710.0
    Given the input value is 710.0
    When I call FastMath.sinh with the input
    Then the result should be finite
    And the result should be approximately 1.1169973830808557E308
    And the result should match Math.sinh within 1 ULP
