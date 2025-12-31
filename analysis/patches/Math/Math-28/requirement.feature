Feature: Simplex Solver Anti-Cycling Heuristic

  Background:
    Given a Simplex Solver instance
    And a linear optimization problem with constraints that induce degeneracy

  Scenario: Prevent infinite cycling in Simplex Solver
    Given the solver has performed a significant number of iterations without converging
    When degeneracy occurs (multiple rows tie for the minimum ratio test)
    And the number of iterations exceeds half of the maximum allowed iterations
    Then the solver should revert to a simple pivot row selection rule (e.g., selecting the top-most row) instead of Bland's rule
    And the solver should successfully converge to an optimal solution within the maximum iteration limit

  Scenario: Use Bland's rule for initial iterations
    Given the number of iterations is less than half of the maximum allowed iterations
    When degeneracy occurs (multiple rows tie for the minimum ratio test)
    Then the solver should apply Bland's rule to select the pivot row (choosing the row with the smallest basic variable index)
