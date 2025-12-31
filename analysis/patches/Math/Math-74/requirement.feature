Feature: Efficient Step Size Control for High Order Integrators

  In order to ensure efficient integration and avoid excessive function evaluations
  As a library user
  I want the adaptive step size control to appropriately increase the step size when the error is well within limits, especially for high-order methods

  Scenario: Prevent step size shrinkage when error is well within tolerance
    Given an Embedded Runge-Kutta integrator of order 8
    When the integrator calculates the step size scaling factor for an error ratio of 0.5
    Then the scaling factor should be greater than 1.0
    And the step size should increase for the next step

  Scenario: Integration of polynomial functions with Adams-Moulton
    Given an Adams-Moulton integrator with order greater than or equal to 5 (nSteps >= 4)
    When integrating a polynomial problem (TestProblem6)
    Then the total number of evaluations should be less than 90
