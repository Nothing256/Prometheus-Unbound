Feature: Regula Falsi Solver Convergence

  The Regula Falsi solver should correctly find roots for functions even when the algorithm exhibits slow convergence
  due to one bound remaining fixed (stuck). It should not throw a ConvergenceException if a solution is reachable.

  Scenario: Solve exponential function exp(x) - pi^3 without convergence failure
    Given a Regula Falsi solver
    And a univariate function defined as "f(x) = exp(x) - pi^3"
    When I attempt to solve the function on the interval [1, 10] with a maximum of 3624 evaluations
    Then the solver should return a root approximately 3.4341896575482003
    And the absolute error should be within 1e-15
