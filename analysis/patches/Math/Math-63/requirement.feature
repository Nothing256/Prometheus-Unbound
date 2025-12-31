Feature: Correct NaN handling in MathUtils equality checks

  The MathUtils.equals(double, double) method incorrectly treats two NaN values as equal,
  contradicting its documentation which states it should behave like equals(x, y, 1)
  (which returns false for NaNs). This causes MathUtils.equals(double[], double[])
  to return true for arrays containing NaNs, causing tests to fail.

  Scenario: MathUtils.equals(double[], double[]) returns false for arrays containing NaNs
    Given two double arrays "a" and "b"
    And array "a" contains a NaN value
    And array "b" contains a NaN value at the same index
    When MathUtils.equals(a, b) is called
    Then the result should be false

  Scenario: MathUtils.equals(double, double) returns false for NaN values
    Given two double values "x" and "y"
    And "x" is NaN
    And "y" is NaN
    When MathUtils.equals(x, y) is called
    Then the result should be false

  Scenario: MathUtils.equals(double, double) returns true for equal non-NaN values
    Given two double values "x" and "y"
    And "x" is 1.0
    And "y" is 1.0
    When MathUtils.equals(x, y) is called
    Then the result should be true
