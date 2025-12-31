Feature: Regularized Gamma Function Precision

  The Regularized Gamma P function must provide high-precision results for standard inputs,
  ensuring that the series expansion or continued fraction approximation converges to a 
  value within a tight tolerance (e.g., 10e-15) of the theoretical value.

  Scenario: Calculate Regularized Gamma P for inputs a=1.0 and x=1.0
    Given the value a is 1.0
    And the value x is 1.0
    When I calculate regularizedGammaP(a, x)
    Then the result should be 0.632120558828558
    And the calculation precision should satisfy a tolerance of 1.0e-14
