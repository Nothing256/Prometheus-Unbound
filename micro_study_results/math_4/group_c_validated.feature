Feature: Sub-line Intersection

  Scenario: Intersection of non-intersecting sub-lines in 3D space
    Given a 3D sub-line from (1, 1, 1) to (1.5, 1, 1)
    And a 3D sub-line from (2, 3, 0) to (2, 3, 0.5)
    When calculating the intersection with endpoints included
    Then the intersection result should be null
    When calculating the intersection with endpoints excluded
    Then the intersection result should be null

  Scenario: Intersection of parallel sub-lines in 2D space
    Given a 2D sub-line from (0, 1) to (0, 2)
    And a 2D sub-line from (66, 3) to (66, 4)
    When calculating the intersection with endpoints included
    Then the intersection result should be null
    When calculating the intersection with endpoints excluded
    Then the intersection result should be null
