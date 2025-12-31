Feature: Correctly parse dates with mixed weekyear, month, and week fields

  Parsing a date string that contains weekyear (xxxx), month (MM), and week of weekyear (ww)
  should result in a date that respects the weekyear and week, even if the first day of the
  month falls into a different weekyear.

  Scenario: Parse 2010-01-01 with pattern xxxx-MM-ww
    Given the date time formatter pattern is "xxxx-MM-ww"
    And the chronology is UTC
    When the string "2010-01-01" is parsed to a LocalDate
    Then the resulting LocalDate should be 2010-01-04

  Scenario: Parse 2011-01-01 with pattern xxxx-MM-ww
    Given the date time formatter pattern is "xxxx-MM-ww"
    And the chronology is UTC
    When the string "2011-01-01" is parsed to a LocalDate
    Then the resulting LocalDate should be 2011-01-03
