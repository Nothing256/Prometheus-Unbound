Feature: DelegatingMethod Equality
  As a developer using Mockito
  I want DelegatingMethod to correctly implement equality logic
  So that I can compare delegated methods reliably

  Scenario: Equality between two DelegatingMethod instances wrapping the same Method
    Given a method "someMethod" exists in class "Something"
    And a DelegatingMethod "d1" wraps "someMethod"
    And another DelegatingMethod "d2" wraps "someMethod"
    When I call d1.equals(d2)
    Then the result should be true

  Scenario: Equality between a DelegatingMethod and its wrapped Method
    Given a method "someMethod" exists in class "Something"
    And a DelegatingMethod "d1" wraps "someMethod"
    When I call d1.equals(someMethod)
    Then the result should be true

  Scenario: Inequality between two DelegatingMethod instances wrapping different Methods
    Given a method "someMethod" exists in class "Something"
    And a method "otherMethod" exists in class "Something"
    And a DelegatingMethod "d1" wraps "someMethod"
    And a DelegatingMethod "d2" wraps "otherMethod"
    When I call d1.equals(d2)
    Then the result should be false
