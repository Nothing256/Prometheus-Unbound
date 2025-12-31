Feature: Maintain Uniqueness in SetUniqueList when modifying elements

  Scenario: Setting a unique element updates the internal uniqueness set
    Given a SetUniqueList containing the strings "Apple", "Lemon", "Orange"
    When I set the element at index 1 to "Strawberry"
    Then the list should contain "Apple", "Strawberry", "Orange"
    And the list size should be 3
    When I attempt to add "Strawberry" at index 1
    Then the list size should still be 3
    And the list should still contain "Apple", "Strawberry", "Orange"
    When I attempt to add "Lemon" at index 1
    Then the list size should be 4
    And the list should contain "Apple", "Lemon", "Strawberry", "Orange"
