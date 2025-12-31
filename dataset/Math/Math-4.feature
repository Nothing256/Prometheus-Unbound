Feature: SubLine Intersection

  Scenario: Intersection of sub-lines defined on non-intersecting infinite lines
    Given a sub-line "sub1" defined by points (1, 1, 1) and (1.5, 1, 1)
    And a sub-line "sub2" defined by points (2, 3, 0) and (2, 3, 0.5)
    When I compute the intersection of "sub1" and "sub2"
    Then the result should be null
