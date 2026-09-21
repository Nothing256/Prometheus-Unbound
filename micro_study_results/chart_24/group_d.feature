Feature: GrayPaintScale out-of-bounds paint retrieval

  Scenario: Request paint for a value below the lower bound
    Given a GrayPaintScale with a lower bound of 0.0 and an upper bound of 1.0
    When a paint is requested for the value -0.5
    Then the returned paint should be Color.black

  Scenario: Request paint for a value above the upper bound
    Given a GrayPaintScale with a lower bound of 0.0 and an upper bound of 1.0
    When a paint is requested for the value 1.5
    Then the returned paint should be Color.white
