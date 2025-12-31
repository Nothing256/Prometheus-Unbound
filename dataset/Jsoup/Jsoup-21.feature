Feature: CSS Selector List Parsing

  Scenario: Selectors with commas inside nested functional pseudo-classes
    The parser must correctly identify the comma as part of the nested expression (e.g., regex in :matches) rather than a selector list separator.

    Given an HTML document with the following content:
      """
      <p name='1,2'>One</p><div>Two</div><ol><li>123</li><li>Text</li></ol>
      """
    When I select elements using the selector "div, li:matches([0-9,]+)"
    Then the selection should not throw a "PatternSyntaxException"
    And the result should contain 2 elements
    And the first element should be the "div" with text "Two"
    And the second element should be the "li" with text "123"
