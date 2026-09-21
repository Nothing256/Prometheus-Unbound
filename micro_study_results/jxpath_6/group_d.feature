Feature: Multi-valued variable equality comparison

  Scenario: Evaluating equality between a multi-valued variable and a matching element
    Given a JXPath context with a variable "d" initialized to an array containing "a" and "b"
    When the XPath expression "$d = 'a'" is evaluated
    Then the result should be true

  Scenario: Evaluating equality between a multi-valued variable and another matching element
    Given a JXPath context with a variable "d" initialized to an array containing "a" and "b"
    When the XPath expression "$d = 'b'" is evaluated
    Then the result should be true
