Feature: Levenberg-Marquardt Optimizer Correctness

  The optimizer should be able to solve standard least-squares problems
  like the Jennrich-Sampson function with high precision.

  Scenario: Minimizing the Jennrich-Sampson function
    Given the Levenberg-Marquardt optimizer configured with:
      | cost relative tolerance       | 1.4901161193847656E-8 |
      | parameters relative tolerance | 1.4901161193847656E-8 |
      | orthogonality tolerance       | 2.220446049250313E-16 |
    And the Jennrich-Sampson function with start point:
      | 0.3 |
      | 0.4 |
    When the optimizer minimizes the function
    Then the resulting parameters should be approximately:
      | 0.2578199266 |
      | 0.2578299768 |
    And the parameter absolute error tolerance should be within 1.25E-5
