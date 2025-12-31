Feature: Default behavior for Comparable mocks

  Scenario: Mock compared to itself returns 0
    Given a mock object that implements Comparable
    When the "compareTo" method is called with the mock object itself as the argument
    Then the result should be 0
