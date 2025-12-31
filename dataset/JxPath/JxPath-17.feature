Feature: DOM Attribute Iterator Wildcard Support

  Scenario: Retrieve all attributes using the wildcard selector including namespaced attributes
    Given a DOM element exists with the following attributes:
      | Name           | Value | Namespace URI |
      | discount       | 20%   |               |
      | price:discount | 10%   | priceNS       |
    When I evaluate the XPath expression "@*" on this element
    Then the result should contain both attributes
    And the result should contain the value "20%"
    And the result should contain the value "10%"
