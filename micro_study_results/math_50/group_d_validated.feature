Feature: Regula Falsi solver evaluation limit

  Scenario: Exceeding maximum evaluations when solving function with slow convergence
    Given a Regula Falsi solver
    And the univariate function "f(x) = exp(x) - pi^3"
    When solving for a root within the interval [1, 10] with a maximum of 3624 evaluations
    Then a TooManyEvaluationsException should be thrown
