Feature: TreeList Iterator Robustness

  Scenario: ListIterator behaves correctly when calling previous() immediately after remove()
    Given a TreeList containing the strings "A", "B", "C", "D"
    And a ListIterator is positioned after "B"
    When I iterate previous to "B"
    And I remove the current element "B" via the iterator
    Then the next call to previous() on the iterator should return "A"
