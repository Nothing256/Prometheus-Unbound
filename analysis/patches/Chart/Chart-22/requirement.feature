Feature: KeyedObjects2D Column Removal

  Scenario: Remove a column from a sparse data structure where not all rows contain the column key
    Given a KeyedObjects2D instance containing:
      | Row | Column | Value |
      | R1  | C1     | Obj1  |
      | R2  | C2     | Obj2  |
    When I remove the column with key "C2"
    Then the column count should be 1
    And the value at row "R1", column "C1" should be "Obj1"
    And the column key "C2" should no longer exist

  Scenario: Attempt to remove a column using a null key
    Given a KeyedObjects2D instance
    When I attempt to remove a column with a null key
    Then an IllegalArgumentException should be thrown

  Scenario: Attempt to remove a column using an unknown key
    Given a KeyedObjects2D instance
    When I attempt to remove a column with key "UnknownKey"
    Then an UnknownKeyException should be thrown
