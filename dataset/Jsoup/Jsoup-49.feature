Feature: Manipulate Child Nodes in Element

  Scenario: Move multiple children to the beginning of the same parent
    Given I have a parent element "body"
    And the parent element has children "div1", "div2", "div3", "div4" in that order
    And "div3" contains the text "Check"
    When I move children "div3" and "div4" to position 0 of "body"
    Then the parent element should have children "div3", "div4", "div1", "div2" in that order
    And the total number of children in "body" should be 4
    And the element "div3" should still contain the text "Check"
