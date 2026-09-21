Feature: DateTime creation during DST overlap in London time zone

  As a user of the date-time library
  I want a local time falling within an autumn DST cutover overlap to resolve to the daylight saving time offset
  So that earlier instants during an ambiguous hour are correctly favoured

  Scenario: Creating a DateTime during the autumn DST cutover overlap in Europe/London
    Given the time zone is "Europe/London"
    When a DateTime is created for year 2011, month 10, day 30, hour 1, and minute 15
    Then the resulting string representation should be "2011-10-30T01:15:00.000+01:00"
    And adding 1 hour to the DateTime should result in "2011-10-30T01:15:00.000Z"
