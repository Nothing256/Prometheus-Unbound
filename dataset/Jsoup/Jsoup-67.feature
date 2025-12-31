Feature: Deep Stack Parsing Performance

  Scenario: Parsing deeply nested definition lists efficiently
    Given a large HTML string with 25000 nested "<dl><dd>" pairs
    When the HTML is parsed
    Then the parsing should complete within 1 second
    And the resulting document body should have 2 child nodes
    And the document should contain 25000 "dd" elements
