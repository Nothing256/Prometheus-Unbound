Feature: Regula Falsi Solver Convergence

  Scenario: Regula Falsi Solver should converge for convex functions within reasonable evaluations
    The Regula Falsi solver is expected to handle convex/concave functions robustly, avoiding the slow linear convergence
    characteristic of the naive False Position method. It should employ a modification (such as the Illinois method strategy
    referenced in its documentation) to ensure convergence within a reasonable number of evaluations.

    Given a Regula Falsi solver is initialized
    When it is used to solve the function "f(x) = exp(x) - pi^3" in the interval [1, 10]
    And the maximum number of evaluations is set to 3624
    Then the solver should find the root approximately 3.4341896575482003
    And it should not throw a MaxEvaluationsExceededException