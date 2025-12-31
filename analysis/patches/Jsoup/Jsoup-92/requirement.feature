Feature: Attribute Parsing and Deduplication

  In order to parse HTML attributes correctly according to spec and configuration
  As a parsing engine
  I need to handle duplicate attributes by retaining the first occurrence and respecting case sensitivity settings

  Scenario: Retains attributes of different case if sensitive
    Given the parser is configured to preserve case
    When I parse the HTML "<p One=One One=Two one=Three two=Four two=Five Two=Six>Text</p>"
    Then the element should have attribute "One" with value "One"
    And the element should have attribute "one" with value "Three"
    And the element should have attribute "two" with value "Four"
    And the element should have attribute "Two" with value "Six"
    And the generated HTML should be "<p One=\"One\" one=\"Three\" two=\"Four\" Two=\"Six\">Text</p>"

  Scenario: Drops duplicate attributes (Case Insensitive Default)
    Given the parser is configured to default settings
    When I parse the HTML "<p One=One ONE=Two Two=two one=Three One=Four two=Five>Text</p>"
    Then the element should have attribute "one" with value "One"
    And the element should have attribute "two" with value "two"
    And the generated HTML should be "<p one=\"One\" two=\"two\">Text</p>"
