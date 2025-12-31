Feature: Levenberg-Marquardt Optimizer Robustness

  Background:
    Given I have a LevenbergMarquardtOptimizer
    And I configure the optimizer with the following tolerances:
      | costRelativeTolerance | 1.4901161193847656e-08 |
      | parRelativeTolerance  | 1.4901161193847656e-08 |
      | orthoTolerance        | 2.220446049250313e-16  |

  Scenario: Optimization of Jennrich-Sampson function
    Given a JennrichSampson function with m=10
    And the theoretical minimum cost is 64.5856498144943
    And the theoretical minimum parameters are:
      | 0.2578330049      |
      | 0.257829976764542 |
    And the start point is:
      | 0.3 |
      | 0.4 |
    When I optimize the function
    Then the RMS error should be equal to the theoretical minimum cost within 1.0e-8 relative accuracy
    And the optimized parameters should be equal to the theoretical minimum parameters within 1.0e-5 relative accuracy
