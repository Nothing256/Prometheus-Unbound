Feature: Week number formatting in FastDateFormat
  As a user of FastDateFormat
  I want to ensure that week numbers are formatted correctly according to locale-specific rules
  So that dates are properly assigned to weeks based on the locale's definition of week numbering

  Scenario: Format week number for January 1, 2010 in Swedish locale
    Given a date of January 1, 2010 (which is a Friday)
    And a Swedish locale (sv_SE) is used
    When the date is formatted with pattern "EEEE', week 'ww"
    Then the result should be "fredag, week 53"
    And not "fredag, week 1"
    And this reflects that January 1, 2010 belongs to the last week of 2009 according to Swedish week numbering rules

  Scenario: Week number calculation respects locale-specific first week rules
    Given a FastDateFormat instance with pattern containing 'w' (week in year)
    And a specific locale that defines first week differently (e.g. Swedish week 1 must contain a Thursday)
    When formatting dates near year boundaries
    Then the week number should follow the locale's specific rules for determining the first week of the year
    And not rely on default locale-agnostic calendar calculations