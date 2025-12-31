Feature: W3C DOM Conversion handles undeclared namespaces

  Scenario: Converting an element with an undeclared namespace prefix
    Given I have a Jsoup Document containing the HTML "<fb:like>One</fb:like>"
    And the namespace prefix "fb" is not declared in the document
    When I convert the Jsoup Document to a W3C DOM Document
    Then the converted W3C Element for "fb:like" should be created successfully
    And the W3C Element should have a Node Name of "fb:like"
    And the W3C Element should have a Local Name of "like"
    And the W3C Element should have a null Namespace URI
