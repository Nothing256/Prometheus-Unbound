Feature: Multi-Directional Direct Search Optimization

  Background:
    Given a MultiDirectional optimizer is initialized

  Scenario: Optimizer handles contraction without infinite looping
    Given the optimizer is configured with max iterations 100
    And a Gaussian2D function with maximum at (0, 0) and standard deviation 1.0
    When the optimizer maximizes the function starting from the maximum position
    Then the optimizer should successfully find the maximum within the iteration limit
    And the result coordinates should be approximately (0, 0)
    And the result value should be approximately the maximum value of the function

  Scenario: Optimizer finds local minimum for complex function
    Given the optimizer is configured with convergence checker (1.0e-11, 1.0e-30)
    And the "fourExtrema" function is defined
    When the optimizer minimizes the function starting from (-3.0, 0.0)
    Then the result should be the local minimum approximately at (-3.841947, -1.391745)
    And the result value should be approximately 0.2373295
    And the number of evaluations should be sufficient to ensure robust convergence (greater than 60)