Feature: XPath Equality Comparison with Arrays

  Scenario: Variable containing an array should be treated as a node set in equality comparisons
    Given a variable "d" is defined as a String array containing "a" and "b"
    When the XPath expression "$d = 'a'" is evaluated
    Then the result should be Boolean true
    And when the XPath expression "$d = 'b'" is evaluated
    Then the result should be Boolean true
