Feature: Normal Distribution Cumulative Probability Extreme Values

  To prevent convergence exceptions and ensure correct return values for extreme inputs,
  the cumulative probability calculation must handle values that are more than 20
  standard deviations away from the mean by returning 0.0 or 1.0 respectively.

  Scenario: Cumulative probability for values more than 20 standard deviations above mean
    Given a Normal distribution with mean 0.0 and standard deviation 1.0
    When I evaluate the cumulative probability at 21.0
    Then the result should be 1.0
    And no MathException should be thrown

  Scenario: Cumulative probability for values more than 20 standard deviations below mean
    Given a Normal distribution with mean 0.0 and standard deviation 1.0
    When I evaluate the cumulative probability at -21.0
    Then the result should be 0.0
    And no MathException should be thrown
