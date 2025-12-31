Feature: Simplex Solver Correctness

  Scenario: Decision variables must not be identified as basic in the objective function row
    The solver must ensure that variables are only considered basic if they are basic in the constraint rows, 
    not in the objective function row. This prevents variables from incorrectly inheriting values from the 
    objective function's RHS (which represents the optimal value), which can lead to negative variable values 
    even when non-negative restrictions are in place.

    Given a linear optimization problem with objective function "minimize x0 + x1"
    And the linear constraints:
      | x0 = 1 |
    And the variables are restricted to non-negative values
    When the simplex solver optimizes the problem
    Then the solution point should be:
      | x0 | 1.0 |
      | x1 | 0.0 |
    And the variable "x1" should not be negative
