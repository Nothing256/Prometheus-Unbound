Feature: DateTime creation in time zones with DST transitions
  As a user of the DateTime library
  I want accurate timezone conversion when creating DateTime objects
  So that local times are correctly interpreted during DST transitions

  Scenario: Creating DateTime in Europe/London after autumn DST transition
    Given the timezone Europe/London on 2011-10-30
      And the local time is 01:15 on 2011-10-30
    When I create a DateTime object with these parameters
    Then the resulting DateTime should have offset +01:00 (BST)
      And the string representation should be "2011-10-30T01:15:00.000+01:00"
    And when I add one hour to this DateTime
    Then the result should be "2011-10-30T01:15:00.000Z" (UTC)

  Scenario: DateTime creation during timezone transition gap
    Given a timezone with a DST transition creating a gap (like America/Grand_Turk at midnight)
      And the local time falls within this gap
    When I try to create a DateTime object for the gap time
    Then an IllegalArgumentException should be thrown
      And the error message should indicate "Illegal instant due to time zone offset transition"

  Scenario: DateTime creation during timezone overlap
    Given a timezone with a DST transition creating an overlap (like Europe/London autumn transition)
      And the local time falls within this overlap (ambiguous time)
    When I create a DateTime object for the overlapping time  
    Then the earlier offset (daylight saving time) should be used by default
      And the time should be correctly interpreted according to timezone rules