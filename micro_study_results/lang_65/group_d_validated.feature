Feature: Date truncation and rounding during Daylight Saving Time transition

  Scenario Outline: Truncate date during Daylight Saving Time fall-back changeover
    Given the default time zone is set to "<timezone>"
    And a date "<input_date>" with timestamp <input_millis>
    When DateUtils.truncate is invoked with the date and field "<field>"
    Then the resulting date should have timestamp <expected_millis>
    And the resulting date formatted as "yyyy-MM-dd HH:mm:ss.SSS z" should be "<expected_date>"

    Examples:
      | timezone | input_date                  | input_millis  | field                | expected_millis | expected_date               |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.MILLISECOND | 1099206123004   | 2004-10-31 01:02:03.004 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.SECOND      | 1099206123000   | 2004-10-31 01:02:03.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.MINUTE      | 1099206120000   | 2004-10-31 01:02:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.HOUR_OF_DAY | 1099206000000   | 2004-10-31 01:00:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.HOUR        | 1099206000000   | 2004-10-31 01:00:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.DATE        | 1099202400000   | 2004-10-31 00:00:00.000 MDT |

  Scenario Outline: Round date during Daylight Saving Time fall-back changeover
    Given the default time zone is set to "<timezone>"
    And a date "<input_date>" with timestamp <input_millis>
    When DateUtils.round is invoked with the date and field "<field>"
    Then the resulting date should have timestamp <expected_millis>
    And the resulting date formatted as "yyyy-MM-dd HH:mm:ss.SSS z" should be "<expected_date>"

    Examples:
      | timezone | input_date                  | input_millis  | field                | expected_millis | expected_date               |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.MILLISECOND | 1099206123004   | 2004-10-31 01:02:03.004 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.SECOND      | 1099206123000   | 2004-10-31 01:02:03.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.MINUTE      | 1099206120000   | 2004-10-31 01:02:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.HOUR_OF_DAY | 1099206000000   | 2004-10-31 01:00:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.HOUR        | 1099206000000   | 2004-10-31 01:00:00.000 MDT |
      | MST7MDT  | 2004-10-31 01:02:03.004 MDT | 1099206123004 | Calendar.DATE        | 1099202400000   | 2004-10-31 00:00:00.000 MDT |
