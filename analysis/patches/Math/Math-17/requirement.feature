Feature: Dfp Multiplication by Integer

  The Dfp.multiply(int) method should support multiplication by any integer value,
  not just those representing a single digit in the internal radix (0 to 9999).

  Scenario: Multiplying by an integer equal to the radix
    Given I have a Dfp value of "1"
    When I multiply it by the integer 10000
    Then the result should be "10000"
    And the result should not be NaN
    And the operation should not raise an invalid flag

  Scenario: Multiplying by an integer larger than the radix
    Given I have a Dfp value of "2"
    When I multiply it by the integer 1000000
    Then the result should be "2000000"
    And the result should not be NaN
    And the operation should not raise an invalid flag
