Feature: BrentOptimizer Precision and Convergence

  The BrentOptimizer must adhere strictly to the configured absolute and relative accuracy settings.
  It should not terminate the optimization process prematurely if the guaranteed precision (based on the search interval size) exceeds the specified accuracy thresholds.

  Scenario: Optimize Quintic function with strict accuracy requirements
    Given a BrentOptimizer instance
    And the absolute accuracy is set to 1.0e-9
    And the relative accuracy is set to 1.0e-14
    And the function to minimize is "QuinticFunction" defined as f(x) = (x-1)*(x-0.5)*x*(x+0.5)*(x+1)
    When I optimize the function in the interval [-0.3, -0.2]
    Then the result should be -0.271956127951169 within a tolerance of 1.0e-9
