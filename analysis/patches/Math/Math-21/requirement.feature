Feature: Rectangular Cholesky Decomposition Pivoting

  Scenario: Decompose a matrix with a zero row in the middle
    Given a 5x5 symmetric positive semidefinite matrix "m3" defined as:
      | 0.013445532 | 0.010394690 | 0.0 | 0.009881156 | 0.010499559 |
      | 0.010394690 | 0.023006616 | 0.0 | 0.008196856 | 0.010732709 |
      | 0.0         | 0.0         | 0.0 | 0.0         | 0.0         |
      | 0.009881156 | 0.008196856 | 0.0 | 0.019023866 | 0.009210099 |
      | 0.010499559 | 0.010732709 | 0.0 | 0.009210099 | 0.019107243 |
    When I perform a Rectangular Cholesky Decomposition on "m3" with a threshold of 1.0e-10
    Then the rebuilt matrix from the decomposition should match "m3" within a tolerance of 1.0e-16
    And the rank of the decomposition should be 4
