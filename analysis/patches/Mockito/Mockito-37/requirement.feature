Feature: Answer Validator Logic

  Scenario: Validate CallsRealMethods answer cannot be used on interfaces
    Given an invocation on an interface method
    And the stubbing answer is to call real methods
    When the answer is validated
    Then a MockitoException should be thrown because interfaces do not have real methods to call