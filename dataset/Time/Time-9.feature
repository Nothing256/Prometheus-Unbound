Feature: DateTimeZone Offset Creation Validation

  As a user of the Joda-Time library
  I want to ensure that creating a DateTimeZone with specific hour and minute offsets respects the valid range
  So that invalid time zones are not created

  Scenario: Reject positive offset hours outside the valid range
    Given the hour offset is 24
    And the minute offset is 0
    When I attempt to create a DateTimeZone with these offsets
    Then an IllegalArgumentException should be thrown

  Scenario: Reject negative offset hours outside the valid range
    Given the hour offset is -24
    And the minute offset is 0
    When I attempt to create a DateTimeZone with these offsets
    Then an IllegalArgumentException should be thrown

  Scenario: Accept maximum valid positive offset
    Given the hour offset is 23
    And the minute offset is 59
    When I attempt to create a DateTimeZone with these offsets
    Then a valid DateTimeZone should be created with ID "+23:59"

  Scenario: Accept maximum valid negative offset
    Given the hour offset is -23
    And the minute offset is 59
    When I attempt to create a DateTimeZone with these offsets
    Then a valid DateTimeZone should be created with ID "-23:59"
