Feature: Partial constructor field order validation

  Scenario: Constructing a Partial with year before era throws IllegalArgumentException
    Given an array of field types containing "year", "era", and "monthOfYear"
    And an array of integer values [1, 1, 1]
    When a Partial is constructed with these types and values
    Then an IllegalArgumentException should be thrown indicating the types must be in order largest-smallest

  Scenario: Constructing a Partial with dayOfMonth before era throws IllegalArgumentException
    Given an array of field types containing "year", "dayOfMonth", and "era"
    And an array of integer values [1, 1, 1]
    When a Partial is constructed with these types and values
    Then an IllegalArgumentException should be thrown indicating the types must be in order largest-smallest
