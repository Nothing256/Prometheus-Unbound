Feature: Rotation Construction from Vector Pairs

  Scenario: Handle negative intermediate dot product during rotation construction (Issue 639)
    Given vector u1 with x=-4921139.660228362, y=-21512093.53578059, z=-890093.4549547108
    And vector u2 with x=-2723858602.476483, y=-2169665851.637583, z=67497042838.38459
    And vector v1 as (1, 0, 0)
    And vector v2 as (0, 0, 1)
    When a Rotation is constructed from u1, u2, v1, v2
    Then the rotation scalar component q0 should be approximately 0.6228370359608201
    And the rotation vector component q1 should be approximately 0.0257707621456499
    And the rotation vector component q2 should be approximately -0.0000000002503012
    And the rotation vector component q3 should be approximately -0.7819270390861109
