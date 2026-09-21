Feature: Gray paint scale lookup

  Scenario: Request paint for a value below the lower bound
    Given a gray paint scale with lower bound 0.0 and upper bound 1.0
    When a paint is requested for value -0.5
    Then the resulting color should be black

  Scenario: Request paint for a value above the upper bound
    Given a gray paint scale with lower bound 0.0 and upper bound 1.0
    When a paint is requested for value 1.5
    Then the resulting color should be white
