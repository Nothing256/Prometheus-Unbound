Feature: DateTime creation during daylight saving time overlap

  Scenario: Constructing a DateTime during DST autumn overlap in Europe/London
    Given the time zone is "Europe/London"
    When a DateTime is created for year 2011, month 10, day 30, hour 1, and minute 15 in this time zone
    Then its string representation should be "2011-10-30T01:15:00.000+01:00"
    And adding 1 hour to the DateTime should produce "2011-10-30T01:15:00.000Z"
