Feature: Correctly parsing numeric characters in HTML

  The parser must distinguish between the digit '0' (U+0030) and the null character (U+0000).
  The digit '0' is valid text and should be preserved in the document structure.

  Scenario: Parsing input containing the digit '0'
    Given the input HTML is "0<p>0</p>"
    When the input is parsed
    Then the result body HTML should be "0
<p>0</p>"
    And the text "0" should be present in the body
    And the text "0" should be present in the paragraph element

