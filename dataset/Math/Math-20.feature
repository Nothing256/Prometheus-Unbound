Feature: CMA-ES Optimizer Boundary Compliance

  The CMA-ES optimizer must strictly respect the defined boundaries of the search space. 
  Even if the algorithm internally explores or calculates fitness for points outside the bounds (with penalties), 
  the final returned optimum must be a valid point within the specified lower and upper bounds.

  Scenario: Optimization result must be within bounds when optimum is outside
    Given a CMA-ES optimizer is initialized
    And a fitness function is defined as f(x) = (1 - x[0])^2
    And the lower bound is set to -1.0e6
    And the upper bound is set to 0.5
    And the start point is set to 0.0
    When the optimizer performs minimization
    Then the returned solution point x[0] should be less than or equal to 0.5
