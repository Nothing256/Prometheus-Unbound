Feature: HTML Parser Robustness against Rough Attributes

  Scenario: Parsing rough attributes with unescaped less-than sign
    Given the HTML input "<p =a>One<a <p>Something</p>Else"
    When the HTML is parsed
    Then the parsed output should be "<p =a>One<a></a></p><p><a>Something</a></p><a>Else</a>"

  Scenario: Less-than sign breaks tag or attribute name parsing
    Given the HTML input "<a <p>"
    When the HTML is parsed
    Then the parsing logic should treat "<" as a delimiter for the name
    And the result should be an empty "<a>" element followed by an empty "<p>" element
    And the "<a>" element should not have an attribute named "<p"
