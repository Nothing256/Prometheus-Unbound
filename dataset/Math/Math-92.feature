Feature: Exact Binomial Coefficient Calculation

  The binomial coefficient method must return exact integer results for all inputs where the
  result fits within a Java long primitive. The current implementation relying on floating-point
  logarithms fails to provide exact results for inputs like n=48, k=22.

  Scenario: Calculate binomial coefficient with exact precision for n=48, k=22
    Given I need to calculate the binomial coefficient "n choose k"
    When n is 48
    And k is 22
    Then the result should be 27385657281648

  Scenario: Calculate binomial coefficient near the limit of Long.MAX_VALUE
    Given I need to calculate the binomial coefficient "n choose k"
    When n is 66
    And k is 33
    Then the result should be the exact value 7219428434016265740

  Scenario: Handle overflow for results exceeding Long.MAX_VALUE
    Given I need to calculate the binomial coefficient "n choose k"
    When n is 67
    And k is 34
    Then the calculation should throw an ArithmeticException
