Feature: Least Squares Optimization Memory Efficiency

  In order to analyze large datasets containing many observations
  As a developer using the optimization library
  I want the least squares optimizer to handle a large number of observations without exhausting memory

  Scenario: Fitting a polynomial to a large sample with diagonal weights
    Given a random polynomial of degree 9
    And a dataset of 40000 points generated from this polynomial with noise
    And each point has a weight of 1.0, resulting in a diagonal weight matrix
    When I fit a polynomial to this dataset using the Levenberg-Marquardt optimizer
    Then the fitting process should complete successfully
    And the fitted polynomial coefficients should approximate the original polynomial
