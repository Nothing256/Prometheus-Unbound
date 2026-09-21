Feature: Partial field addition validation

  Scenario: Adding a conflicting field type to a Partial
    Given a Partial instance containing field hourOfDay with value 10 and minuteOfHour with value 20
    When field clockhourOfDay with value 6 is added using with
    Then an IllegalArgumentException must be thrown
    And the original Partial instance must remain unchanged with hourOfDay 10 and minuteOfHour 20
