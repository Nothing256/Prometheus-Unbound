Feature: Multi-valued variable equality comparison

  Scenario: Comparing a multi-valued variable with an element it contains
    Given a variable "d" containing the values "a" and "b"
    When the XPath expression "$d = 'a'" is evaluated
    Then the result should be true

  Scenario: Comparing a multi-valued variable with another element it contains
    Given a variable "d" containing the values "a" and "b"
    When the XPath expression "$d = 'b'" is evaluated
    Then the result should be true
