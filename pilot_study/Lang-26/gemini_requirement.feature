Feature: FastDateFormat Locale Respect
  In order to ensure correct date formatting across different regions
  As a developer using the Commons Lang library
  I want FastDateFormat to respect the provided Locale for all calendar calculations, including week of year

  Scenario: Formatting week of year for a locale with ISO 8601 rules (Swedish)
    Given I have a FastDateFormat instance for pattern "EEEE', week 'ww" and locale "sv_SE"
    And the date is "2010-01-01 12:00:00"
    When I format the date
    Then the result should be "fredag, week 53"
