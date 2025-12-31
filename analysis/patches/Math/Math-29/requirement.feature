Feature: Sparse Vector Element-by-Element Division

  Scenario: Dividing mixed type vectors with zeros results in NaN
    Given a sparse vector v1 with values:
      | index | value |
      | 0     | 0.0   |
      | 1     | 1.0   |
      | 2     | 0.0   |
    And a dense vector v2 with values:
      | index | value |
      | 0     | 0.0   |
      | 1     | 2.0   |
      | 2     | 1.0   |
    When I compute the element-by-element division of v1 by v2
    Then the result at index 0 should be NaN
    And the result at index 1 should be 0.5
    And the result at index 2 should be 0.0
