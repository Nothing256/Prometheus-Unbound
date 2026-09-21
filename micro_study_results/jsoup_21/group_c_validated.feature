Feature: CSS Selector parsing with commas and combinator groups

  Scenario: Attribute selector containing a comma in attribute value
    Given an HTML document:
      """
      <p name='1,2'>One</p><div>Two</div><ol><li>123</li><li>Text</li></ol>
      """
    When selecting elements with query "[name=1,2]"
    Then 1 element should be selected

  Scenario: Selector group containing regex with comma in pseudo-class
    Given an HTML document:
      """
      <p name='1,2'>One</p><div>Two</div><ol><li>123</li><li>Text</li></ol>
      """
    When selecting elements with query "div, li:matches([0-9,]+)"
    Then 2 elements should be selected
    And the 1st selected element should have tag "div"
    And the 2nd selected element should have tag "li" and text "123"

  Scenario: Mixed combinators with group selector
    Given an HTML document:
      """
      <div class=foo><ol><li>One<li>Two<li>Three</ol></div>
      """
    When selecting elements with query ".foo > ol, ol > li + li"
    Then 2 elements should be selected
    And the 1st selected element should have tag "li"
    And the 2nd selected element should have text "Three"
