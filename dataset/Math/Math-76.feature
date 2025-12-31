Feature: Singular Value Decomposition Correctness
  In order to perform reliable linear algebra operations
  As a developer using the math library
  I want the Singular Value Decomposition to correctly reconstruct the original matrix, even when the matrix is singular (rank deficient)

  Scenario: SVD reconstruction of a singular 3x3 matrix
    Given a 3x3 real matrix defined as:
      | 1.0 | 2.0 | 3.0 |
      | 2.0 | 3.0 | 4.0 |
      | 3.0 | 5.0 | 7.0 |
    When I compute the Singular Value Decomposition of the matrix
    Then the product of U, S, and VT should equal the original matrix within a tolerance of 5.0e-13
