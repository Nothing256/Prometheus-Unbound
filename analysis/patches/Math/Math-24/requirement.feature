Feature: Brent Optimizer Best Point Reporting

  The BrentOptimizer must return the point with the optimal objective value found during the search process.
  It should not simply return the last evaluated point, as the algorithm might evaluate a slightly worse point
  just before convergence or termination, while having seen a better point earlier (specifically stored in variable 'x').

  Scenario: Optimizer reports the best point found for a function with a sharp local minimum
    Given a BrentOptimizer with relative threshold 1e-8 and absolute threshold 1e-100
    And a target function f(x) = Sin(x) + StepFunction(x)
      | step_location           | step_value |
      | 4.71238898038469        | 0.0        |
      | 4.71238899038469        | -1.0       |
      | 4.71238903038469        | 0.0        |
    When I minimize the function in the interval [4.71238830148469, 4.71238996798469]
    Then the returned point should have a function value less than or equal to the value at expected best point 4.712389027602411
