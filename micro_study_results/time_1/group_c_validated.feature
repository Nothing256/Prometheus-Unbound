Feature: Partial constructor field order validation

  Scenario: Creating a Partial with year preceding era
    Given field types [year, era, monthOfYear] and values [1, 1, 1]
    When a Partial is created with the field types and values
    Then an IllegalArgumentException should be thrown
    And the exception message should indicate that types must be in order largest-smallest

  Scenario: Creating a Partial with dayOfMonth preceding era
    Given field types [year, dayOfMonth, era] and values [1, 1, 1]
    When a Partial is created with the field types and values
    Then an IllegalArgumentException should be thrown
    And the exception message should indicate that types must be in order largest-smallest
