Feature: BracketingNthOrderBrentSolver Robustness

  Scenario: Solver converges for a function with a sharp turn and a flat asymptote
    Given a BracketingNthOrderBrentSolver configured with:
      | absoluteAccuracy      | 1.0e-12 |
      | relativeAccuracy      | 1.0e-10 |
      | functionValueAccuracy | 1.0e-22 |
      | maximalOrder          | 5       |
    And a function f(x) defined as "(2 * x + 1) / (1.0e9 * (x + 1))"
    When I solve for the root in the interval [-0.9999999, 30] with start value 15
    And I limit the evaluations to 100
    And I require the allowed solution to be on the RIGHT_SIDE
    Then the solver should return a value approximately -0.5 with a tolerance of 1.0e-10
    And the function value at the result should be greater than or equal to 0.0
