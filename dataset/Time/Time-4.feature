Feature: Prevent duplicate field types in Partial

  Scenario: Adding a field that conflicts with an existing field should throw an exception
    Given a Partial instance with "hourOfDay" set to 10 and "minuteOfHour" set to 20
    When I attempt to create a new Partial by adding "clockhourOfDay" with value 6
    Then an IllegalArgumentException should be thrown
    And the exception message should mention "duplicate"
