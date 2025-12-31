Feature: Tokeniser State handling of unexpected solidus

  Scenario: Unexpected solidus before attribute name
    Given the input HTML "<img /onerror='doMyJob'/>"
    When the HTML is parsed
    Then the parsed document should contain an element "img"
    And the element "img" should have an attribute "onerror" with value "doMyJob"
