Feature: Vector3D Cross Product Accuracy

  As a user of the geometry library
  I want the cross product to be computed accurately
  So that I don't get incorrect results when vectors are nearly parallel or have large coordinates

  Scenario: Calculate cross product of large vectors susceptible to numerical cancellation
    Given two vectors v1 and v2 with large coordinates:
      | vector | x            | y            | z   |
      | v1     | 9070467121.0 | 4535233560.0 | 1.0 |
      | v2     | 9070467123.0 | 4535233561.0 | 1.0 |
    When I compute the cross product of v1 and v2
    Then the result x coordinate should be -1.0
    And the result y coordinate should be 2.0
    And the result z coordinate should be 1.0
