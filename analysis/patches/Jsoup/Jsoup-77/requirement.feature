Feature: XML Parser Tag Normalization

  Scenario: XML parser normalizes end tag names when configured with HTML settings
    Given an XML parser configured with HTML default settings
    When I parse the input "<div>test</DIV><p></p>"
    Then the resulting document should match "<div>\n test\n</div>\n<p></p>"
    And the "p" element should be a sibling of the "div" element

