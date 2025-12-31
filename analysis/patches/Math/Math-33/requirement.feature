Feature: Linear Optimization with Simplex Solver

  Scenario: Optimization with mixed constraints and unrestricted variables
    Given a linear objective function with coefficients [2, 6, 7] and constant term 0
    And the goal is to maximize the objective function
    And the variables are not restricted to non-negative values
    And the following linear constraints:
      | coefficients | relationship | value |
      | 1, 2, 1      | LEQ          | 2     |
      | -1, 1, 1     | LEQ          | -1    |
      | 2, -3, 1     | LEQ          | -1    |
    When the simplex solver optimizes the objective function
    Then the solution point at index 0 should be greater than 0.0
    And the solution point at index 1 should be greater than 0.0
    And the solution point at index 2 should be less than 0.0
    And the objective value should be 2.0
