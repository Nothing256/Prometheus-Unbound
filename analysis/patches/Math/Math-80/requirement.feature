Feature: Accurate Eigen Decomposition

  The system must correctly calculate the eigenvalues and eigenvectors for symmetric tridiagonal matrices, 
  avoiding duplications or inaccuracies even in cases that require complex splitting or deflation.

  Scenario: Calculate eigenvalues for the Mathpbx02 failure case
    Given a symmetric tridiagonal matrix with the following main diagonal:
      | 7484.860960227216 | 18405.28129035345 | 13855.225609560746 | 10016.708722343366 | 559.8117399576674 | 6750.190788301587 | 71.21428769782159 |
    And the following secondary diagonal:
      | -4175.088570476366 | 1975.7955858241994 | 5193.178422374075 | 1995.286659169179 | 75.34535882933804 | -234.0808002076056 |
    When the eigen decomposition is computed
    Then the resulting eigenvalues should match the following reference values within 1.0e-3 tolerance:
      | 20654.744890306974 |
      | 16828.208208485466 |
      | 6893.155912634994 |
      | 6757.083016675340 |
      | 5887.799885688558 |
      | 64.30908992324037 |
      | 57.99262879273634 |
