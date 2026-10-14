Feature: BisectionSolver with Initial Guess
  The BisectionSolver should be able to solve for a zero in the given interval
  starting from an initial guess value. The initial guess parameter should be
  considered in the solver's algorithm, particularly when it's closer to the root
  than the midpoint of the interval.

  Scenario: Solve for sine function zero with initial guess
    Given a sine function f(x) = sin(x)
    And an interval [3.0, 3.2] that brackets a root near π
    And an initial guess of 3.1 within the interval
    When the BisectionSolver solves f(x) = 0 with these parameters
    Then the solver should find the root near π (approximately 3.14159)
    And the result should be close to Math.PI within the solver's accuracy

  Scenario: BisectionSolver must respect initial parameter
    Given a BisectionSolver instance
    When calling solve(f, min, max, initial) method
    Then the solver should utilize the initial parameter in its algorithm
    And not simply ignore the initial parameter by calling solve(f, min, max)

  Scenario: Failing test case for Math369 bug
    Given a sine function f(x) = sin(x)
    And interval bounds of 3.0 and 3.2
    And initial guess of 3.1 
    When solving for the root with BisectionSolver
    Then the result should equal Math.PI within the solver's absolute accuracy
    But currently this fails because the initial parameter is ignored