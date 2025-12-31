Feature: CMAES Optimizer Boundary Precision

  Scenario: Optimization accuracy should be maintained with large asymmetric boundaries
    Given the CMAES optimizer is initialized
    And a quadratic fitness function defined as f(x) = (11.1 - x)^2
    And the lower bound is set to -5e16
    And the upper bound is set to 20
    And the start point is 1.0
    When minimizing the function with the CMAES optimizer
    Then the result should be approximately 11.1 within 1e-3 tolerance
