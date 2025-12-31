Feature: BrentSolver Root Finding

  Scenario: Solver handles cases where an endpoint is a root
    Given a differentiable function f(x) = sin(x)
    And a solver for f with default settings
    When I solve for a root in the interval [3.0, 3.141592653589793]
    Then the result should be approximately 3.141592653589793 within the configured accuracy
    And no "IllegalArgumentException" should be thrown even if f(min) and f(max) have the same sign but one is a root
