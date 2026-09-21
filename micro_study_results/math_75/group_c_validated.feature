Feature: Frequency percentage calculation

  Scenario: Calculate percentage of occurrences for an Object value
    Given a frequency distribution
    And the following values are added:
      | value |
      | 1     |
      | 2     |
      | 1     |
      | 2     |
      | 3     |
      | 3     |
      | 3     |
      | 3     |
    When the percentage of values equal to Object 3 is requested
    Then the percentage should be 0.5
