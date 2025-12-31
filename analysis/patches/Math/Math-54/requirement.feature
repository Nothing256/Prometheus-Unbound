Feature: Dfp to Double Conversion for Zero Values

  In order to ensure accurate floating-point representation
  As a developer using the Dfp library
  I want the toDouble method to correctly handle zero values and preserve their sign

  Scenario: Convert Positive Zero Dfp to Double
    Given a Dfp field with 100 digits
    When I create a Dfp instance from value 0.0
    Then the toDouble conversion should return 0.0
    And the result should be positive zero

  Scenario: Convert Negative Zero Dfp to Double
    Given a Dfp field with 100 digits
    When I create a Dfp instance from value -0.0
    Then the toDouble conversion should return -0.0
    And the result should be negative zero

  Scenario: Convert Default Field Zero to Double
    Given a Dfp field with 100 digits
    When I get the default zero value from the field
    Then the toDouble conversion should return 0.0
    And the result should be positive zero
