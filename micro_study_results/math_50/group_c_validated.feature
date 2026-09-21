Feature: Regula Falsi Solver

  Scenario: Throwing exception when maximum evaluations are exceeded
    Given a Regula Falsi solver
    And the objective function "f(x) = exp(x) - pi^3"
    When solving the function on the interval [1, 10] with a maximum evaluation count of 3624
    Then a TooManyEvaluationsException should be thrown
