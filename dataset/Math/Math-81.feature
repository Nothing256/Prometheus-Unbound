Feature: EigenDecompositionImpl Robustness

  Scenario: Decompose a specific 5x5 symmetric tridiagonal matrix causing index overflow
    Given a symmetric tridiagonal matrix with main diagonal:
      | 22.330154644539597 |
      | 46.65485522478641  |
      | 17.393672330044705 |
      | 54.46687435351116  |
      | 80.17800767709437  |
    And secondary diagonal:
      | 13.04450406501361  |
      | -5.977590941539671 |
      | 2.9040909856707517 |
      | 7.1570352792841225 |
    When the eigen decomposition is computed
    Then the process should complete without throwing an exception
    And the real eigenvalues should be approximately:
      | 82.044413207204002 |
      | 53.456697699894512 |
      | 52.536278520113882 |
      | 18.847969733754262 |
      | 14.138204224043099 |
