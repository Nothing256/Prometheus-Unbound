Feature: Linear Optimization with Simplex Solver

  Scenario: Maximize linear objective function with variables not restricted to non-negative
    Given a linear objective function "2*x1 + 6*x2 + 7*x3"
    And linear constraints:
      | expression          | relationship | rhs  |
      | 1*x1 + 2*x2 + 1*x3  | <=           | 2    |
      | -1*x1 + 1*x2 + 1*x3 | <=           | -1   |
      | 2*x1 - 3*x2 + 1*x3  | <=           | -1   |
    And variables are not restricted to non-negative values
    When the linear program is solved to maximize the objective function
    Then an optimal solution should be returned
    And the optimal objective value should be 2.0
    And the solution variable "x1" should be greater than 0.0
    And the solution variable "x2" should be greater than 0.0
    And the solution variable "x3" should be less than 0.0
