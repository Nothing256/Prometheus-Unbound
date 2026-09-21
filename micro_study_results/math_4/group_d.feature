Feature: Sub-line intersection

  Scenario: Intersection of non-intersecting sub-lines in 3D
    Given a 3D sub-line from (1.0, 1.0, 1.0) to (1.5, 1.0, 1.0)
    And another 3D sub-line from (2.0, 3.0, 0.0) to (2.0, 3.0, 0.5)
    When computing the intersection with endpoints included
    Then the intersection should be null
    When computing the intersection with endpoints excluded
    Then the intersection should be null

  Scenario: Intersection of parallel sub-lines in 2D
    Given a 2D sub-line from (0.0, 1.0) to (0.0, 2.0)
    And another 2D sub-line from (66.0, 3.0) to (66.0, 4.0)
    When computing the intersection with endpoints included
    Then the intersection should be null
    When computing the intersection with endpoints excluded
    Then the intersection should be null
