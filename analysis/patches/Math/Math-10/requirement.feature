Feature: Correctness of atan2 in DerivativeStructure for Special Cases

  The atan2 method in DerivativeStructure currently fails to handle special cases
  involving signed zeros (+0.0, -0.0), leading to incorrect values (e.g., NaN) instead
  of the expected IEEE 754 results. The 0-th order derivative (the value) must
  match the behavior of standard math libraries.

  Scenario Outline: Verify atan2 behavior for signed zero inputs
    Given a DerivativeStructure "y" constructed with value <y_val>
    And a DerivativeStructure "x" constructed with value <x_val>
    When the method "atan2" is invoked with "y" and "x"
    Then the value of the resulting DerivativeStructure should be <expected_result>
    And the sign of the value should be <expected_sign>

    Examples:
      | y_val | x_val | expected_result    | expected_sign |
      | +0.0  | +0.0  | 0.0                | +1.0          |
      | +0.0  | -0.0  | 3.141592653589793  | +1.0          |
      | -0.0  | +0.0  | 0.0                | -1.0          |
      | -0.0  | -0.0  | -3.141592653589793 | -1.0          |
