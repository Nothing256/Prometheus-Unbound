Feature: Least Squares Optimization Error Estimation

  Background:
    Given a Least Squares Optimizer

  Scenario: Chi-Square Calculation with Weights
    The Chi-Square statistic is a key component in estimating the errors of the optimized parameters.
    It represents the sum of squared normalized residuals.
    If weights are provided, they correspond to the reciprocal of the variance of the residuals.
    Therefore, the Chi-Square should be calculated as sum(residual^2 * weight).

    Given a set of residuals [1.0, 2.0]
    And a set of weights [2.0, 0.5]
    When I calculate the Chi-Square value
    Then the result should be (1.0^2 * 2.0) + (2.0^2 * 0.5) = 2.0 + 2.0 = 4.0

  Scenario: Parameter Error Estimation with Weights
    The failing test case `testCircleFitting` shows that when weights are 2.0, the estimated error is half of what it should be.
    This implies the Chi-Square is being divided by the weight (or something similar) instead of multiplied.
    
    Given a non-linear least squares problem (e.g. circle fitting)
    And the weights for the measurements are all set to 2.0
    When the optimizer estimates the parameter errors
    Then the estimated errors should be consistent with a Chi-Square calculated using multiplication of weights
    And the estimated errors should be approximately 0.004 for the specific circle fitting test case
