Feature: Case Sensitive HTML Parsing

  Scenario: Parsing unknown tags with mixed case and case preservation enabled
    Given the HTML parser is configured with "preserveCase" set to true
    And the input HTML is "<r><X>A</X><y>B</y></r>"
    When the document is parsed
    Then the resulting body HTML should match "<r> <X> A </X> <y> B </y> </r>"
