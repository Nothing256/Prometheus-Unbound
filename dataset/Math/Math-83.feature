Feature: Simplex Solver Solution Extraction

  Scenario: Correctly identify basic variables in solution extraction
    Given a SimplexTableau in an optimal state
    And the tableau contains variables x1 and x2
    And the objective function row (Z) has a non-zero coefficient for x1 (e.g., 0.1)
    And the objective function row (Z) has a zero coefficient for x2
    And a constraint row has a coefficient of 1.0 for both x1 and x2
    When the solution is extracted using getSolution
    Then x1 should be identified as a non-basic variable (value 0)
    And x2 should be identified as a basic variable
    And the resulting objective value should correspond to x2 being basic
    And the solution value should be 6.9 for the problem maximize 0.2x1 + 0.3x2 subject to x1 + x2 = 23
