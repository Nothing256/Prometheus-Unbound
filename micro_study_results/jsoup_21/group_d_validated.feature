Feature: CSS Selector Parsing with Commas and Combinators

  Scenario: Selector group with a regex containing commas
    Given the HTML "<p name='1,2'>One</p><div>Two</div><ol><li>123</li><li>Text</li></ol>"
    When selecting elements with "[name=1,2]"
    Then 1 element should be returned
    When selecting elements with "div, li:matches([0-9,]+)"
    Then 2 elements should be returned
    And element 0 should have tag name "div"
    And element 1 should have tag name "li"
    And element 1 should have text "123"

  Scenario: Selector group combined with structural combinators
    Given the HTML "<div class=foo><ol><li>One<li>Two<li>Three</ol></div>"
    When selecting elements with ".foo > ol, ol > li + li"
    Then 2 elements should be returned
    And element 0 should have tag name "li"
    And element 1 should have text "Three"
