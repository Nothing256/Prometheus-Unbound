Feature: Double and array equality check

  Scenario: Comparing two NaN double values
    Given a double value of NaN
    And another double value of NaN
    When the two double values are compared for equality
    Then the result should be false

  Scenario: Comparing two double arrays containing NaN
    Given a double array containing NaN
    And another double array containing NaN
    When the two double arrays are compared for equality
    Then the result should be false
