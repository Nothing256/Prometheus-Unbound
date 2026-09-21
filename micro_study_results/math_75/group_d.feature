Feature: Frequency percentage calculation

  Scenario: Calculate the percentage of occurrences for an Object value
    Given a frequency distribution containing the following values:
      | value |
      | 1     |
      | 2     |
      | 1     |
      | 2     |
      | 3     |
      | 3     |
      | 3     |
      | 3     |
    When the percentage of the value 3 is requested as an Object
    Then the percentage should be 0.5
