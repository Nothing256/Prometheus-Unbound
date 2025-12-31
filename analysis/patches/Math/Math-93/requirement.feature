Feature: Exactness of factorialDouble for small integers

  The factorialDouble implementation uses approximations that introduce errors even for
  inputs where the factorial is exactly representable as a double.
  
  Scenario: factorialDouble should be exact for 17
    Given I want to calculate the factorial of 17 as a double
    When I call MathUtils.factorialDouble with 17
    Then the result should be exactly 355687428096000.0
