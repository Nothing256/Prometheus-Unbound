Feature: DateTimeZone DST Overlap Handling

  Background:
    Given the time zone is "Europe/London"

  Scenario: Create DateTime during Fall-back overlap
    # The system should correctly handle the ambiguous local time during the transition from British Summer Time (BST) to Greenwich Mean Time (GMT).
    # When the clocks go back, the hour from 01:00 to 02:00 repeats. The first occurrence is BST (+01:00), and the second is GMT (+00:00).
    # Joda-Time policy is to return the earlier instant (BST) by default for overlaps.

    When I create a DateTime with the date 2011-10-30 and time 01:15:00
    Then the result should be "2011-10-30T01:15:00.000+01:00"

  Scenario: Add duration across the overlap
    # Adding 1 hour to a time just before the "phantom" hour (or within the first occurrence) should land on the second occurrence if it exists.
    # 01:15 BST (+01:00) + 1 hour (duration) = 01:15 GMT (+00:00).
    # Note: 01:15 BST is 00:15 UTC. 00:15 UTC + 1 hour = 01:15 UTC.
    # 01:15 UTC is 01:15 GMT.

    Given I have a DateTime object for "2011-10-30T01:15:00.000+01:00"
    When I add 1 hour to the DateTime
    Then the result should be "2011-10-30T01:15:00.000Z"
