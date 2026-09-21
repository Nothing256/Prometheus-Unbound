Feature: MonthDay addition and subtraction with leap day and end-of-month adjustments

  As a user of MonthDay
  I want to add and subtract months and days
  So that leap days and month boundaries are handled correctly

  Scenario: Add months to leap day
    Given a MonthDay with month 2 and day 29
    When 1 month is added
    Then the resulting MonthDay has month 3 and day 29

  Scenario: Add negative months to leap day
    Given a MonthDay with month 2 and day 29
    When -1 month is added
    Then the resulting MonthDay has month 1 and day 29

  Scenario: Add negative months with end of month adjustment
    Given a MonthDay with month 3 and day 31
    When -1 month is added
    Then the resulting MonthDay has month 2 and day 29

  Scenario: Subtract months from leap day
    Given a MonthDay with month 2 and day 29
    When 1 month is subtracted
    Then the resulting MonthDay has month 1 and day 29

  Scenario: Subtract negative months from leap day
    Given a MonthDay with month 2 and day 29
    When -1 month is subtracted
    Then the resulting MonthDay has month 3 and day 29

  Scenario: Subtract months with end of month adjustment
    Given a MonthDay with month 3 and day 31
    When 1 month is subtracted
    Then the resulting MonthDay has month 2 and day 29

  Scenario: Add days to leap day across month boundary
    Given a MonthDay with month 2 and day 29
    When 1 day is added
    Then the resulting MonthDay has month 3 and day 1

  Scenario: Subtract negative days from leap day across month boundary
    Given a MonthDay with month 2 and day 29
    When -1 day is subtracted
    Then the resulting MonthDay has month 3 and day 1
