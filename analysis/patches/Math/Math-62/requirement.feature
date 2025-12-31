Feature: Multi-Start Univariate Optimization Correctness

  Scenario: Multi-Start optimizer reliably finds the global minimum of a Quintic function
    Given a Quintic function
    And a MultiStartUnivariateRealOptimizer with 5 starts wrapping a BrentOptimizer
    When I optimize the function to minimize it in the interval [-0.3, -0.2]
    Then the resulting optimum point should be approximately -0.2719561293 within a tolerance of 1e-9
