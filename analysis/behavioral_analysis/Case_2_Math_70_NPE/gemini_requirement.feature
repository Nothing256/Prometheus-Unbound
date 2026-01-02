Feature: Bisection Solver Correctness

  The BisectionSolver should correctly utilize the provided function when the solve method is called with a function argument, 
  ensuring it does not rely on the deprecated internal function field which might be uninitialized.

  Scenario: Solve method with function, interval, and initial value uses the provided function
    Given I have a BisectionSolver instance created with the default constructor
    And I have a UnivariateRealFunction defined as "sin(x)"
    When I call the solve method with the function "sin(x)", min 3.0, max 3.2, and initial 3.1
    Then the result should be approximately 3.141592653589793
    And the method should not fail with a NullPointerException
