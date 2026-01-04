Feature: Partial Constructor Field Order Validation

  In order to ensure the integrity of Partial datetime objects
  As a developer using the Joda-Time library
  I want the Partial constructor to validate that the supplied fields are in strictly descending order of duration, even when some fields have unsupported durations

  Scenario: Reject construction when fields are not in descending order of duration (Year before Era)
    Given the field types are [year, era, monthOfYear]
    And the values are [2005, 1, 1]
    When I construct a Partial with these types and values
    Then the construction should fail with an IllegalArgumentException
    And the exception message should indicate that the types must be in order largest-smallest

  Scenario: Reject construction when fields are not in descending order (Standard fields)
    Given the field types are [dayOfMonth, year, monthOfYear]
    And the values are [1, 2005, 1]
    When I construct a Partial with these types and values
    Then the construction should fail with an IllegalArgumentException
    And the exception message should indicate that the types must be in order largest-smallest
