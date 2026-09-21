Feature: Double and array equality comparison

  Scenario: Comparing two double arrays containing NaN
    Given the first double array is [Double.NaN]
    And the second double array is [Double.NaN]
    When the two arrays are compared for equality
    Then the comparison result should be false

  Scenario: Comparing two double values that are both NaN
    Given the first double value is Double.NaN
    And the second double value is Double.NaN
    When the values are compared for equality
    Then the comparison result should be false
