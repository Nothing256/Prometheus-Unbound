Feature: CMAESOptimizer Boundary Range Validation

  The CMAESOptimizer must ensure that the range between upper and lower boundaries
  does not overflow to Infinity, as this causes NaN values during variable normalization
  and denormalization.

  Scenario: Boundary range overflow triggers NumberIsTooLargeException
    Given a CMAESOptimizer
    And a start point defined as [0.0]
    And a lower bound defined as [-1.0e308]
    And an upper bound defined as [1.0e308]
    When I attempt to optimize a function
    Then a NumberIsTooLargeException should be thrown
