Feature: Non-ASCII Tag Name Support

  Scenario: Parsing HTML with non-ASCII tag names
    Given the input HTML is "<進捗推移グラフ>Yes</進捗推移グラフ>"
    When the input is parsed
    Then the document should contain a matching element with the tag name "進捗推移グラフ"
    And the element text should be "Yes"
