Feature: BrentOptimizer Best Point Guarantee

  Scenario: The optimizer must return the best point found, even if it is the initial guess
    Given a univariate function "f" composed of a sine wave and a step function
    And an initial guess "init" is chosen such that "f(init)" is the global minimum in the search interval
    When the BrentOptimizer optimizes "f" starting from "init"
    Then the returned solution "sol" must satisfy "f(sol) <= f(init)"
