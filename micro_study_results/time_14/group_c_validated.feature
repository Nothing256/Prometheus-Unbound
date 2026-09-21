Feature: MonthDay addition and subtraction with leap day and month-end adjustment

  Scenario: Adding months to February 29
    Given a MonthDay of month 2 and day 29
    When 1 month is added
    Then the resulting MonthDay has month 3 and day 29

  Scenario: Adding negative months to February 29
    Given a MonthDay of month 2 and day 29
    When -1 month is added
    Then the resulting MonthDay has month 1 and day 29

  Scenario: Subtracting months from February 29
    Given a MonthDay of month 2 and day 29
    When 1 month is subtracted
    Then the resulting MonthDay has month 1 and day 29

  Scenario: Subtracting negative months from February 29
    Given a MonthDay of month 2 and day 29
    When -1 month is subtracted
    Then the resulting MonthDay has month 3 and day 29

  Scenario: Adding negative months from March 31 with end of month adjustment
    Given a MonthDay of month 3 and day 31
    When -1 month is added
    Then the resulting MonthDay has month 2 and day 29

  Scenario: Subtracting months from March 31 with end of month adjustment
    Given a MonthDay of month 3 and day 31
    When 1 month is subtracted
    Then the resulting MonthDay has month 2 and day 29

  Scenario: Adding days to February 29
    Given a MonthDay of month 2 and day 29
    When 1 day is added
    Then the resulting MonthDay has month 3 and day 1

  Scenario: Subtracting negative days from February 29
    Given a MonthDay of month 2 and day 29
    When -1 day is subtracted
    Then the resulting MonthDay has month 3 and day 1
