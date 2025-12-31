Feature: TokenQueue Balanced Chomping with Quotes
  As a parser component
  I want to correctly identify balanced strings even when they contain quoted delimiters
  So that CSS selectors with brackets in attribute values are parsed correctly

  Scenario: Chomp balanced string with closing bracket inside single quotes
    Given a TokenQueue with content "[data='End]']"
    When chompBalanced is called with arguments '[' and ']'
    Then the result should be "data='End]'"
    And the remaining queue should be empty

  Scenario: Chomp balanced string with closing bracket inside double quotes
    Given a TokenQueue with content "[data="End]"]"
    When chompBalanced is called with arguments '[' and ']'
    Then the result should be "data="End]""
    And the remaining queue should be empty

  Scenario: Chomp balanced string with nested brackets and quotes
    Given a TokenQueue with content "[data='[Another)]]']"
    When chompBalanced is called with arguments '[' and ']'
    Then the result should be "data='[Another)]]'"
    And the remaining queue should be empty
