Feature: Efficient Weight Matrix Square Root in Least Squares Optimizer

  As a user of the Apache Commons Math optimization library
  I want the optimizer to handle large, diagonal weight matrices efficiently
  So that I can fit models to large datasets (e.g., 40,000 points) without encountering OutOfMemoryError due to expensive matrix decompositions

  Scenario: Computing square root of a large DiagonalMatrix
    Given a weight matrix that is an instance of DiagonalMatrix
    And the matrix has a large dimension (e.g., 40,000 rows)
    When the optimizer computes the square root of the weight matrix
    Then it should identify that the matrix is diagonal
    And it should compute the square root by taking the square root of the diagonal elements
    And it should NOT perform a full EigenDecomposition
    And the memory usage should be proportional to the diagonal size (O(N)), not the square of the dimension (O(N^2))

  Scenario: Large sample fitting with PolynomialFitter
    Given a PolynomialFitter is used with a LevenbergMarquardtOptimizer
    And 40,000 observed points are added to the fitter
    When the fit method is called
    Then the optimization should complete successfully
    And it should not throw a java.lang.OutOfMemoryError: Java heap space
