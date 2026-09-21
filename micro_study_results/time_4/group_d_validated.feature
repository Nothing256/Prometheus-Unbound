Feature: Adding a field to Partial

  Scenario: Adding a field that duplicates an existing field type's unit and range
    Given a Partial with "hourOfDay" set to 10 and "minuteOfHour" set to 20
    When adding "clockhourOfDay" with value 6 to the Partial
    Then an IllegalArgumentException should be thrown
    And the original Partial should remain unchanged
