Feature: Safe element-by-element operations on Sparse Real Vectors

  Background:
    Given a sparse real vector "u" with dimension 3 and epsilon 1e-6
    And "u" has entries:
      | index | value |
      | 0     | 1.0   |
      | 2     | 2.0   |
    And a sparse real vector "v" with dimension 3 and epsilon 1e-6
    And "v" has entries:
      | index | value |
      | 1     | 3.0   |
    # v has implicit zeros at indices 0 and 2

  Scenario: Element-by-element multiplication resulting in entry removal
    When I perform element-by-element multiplication "w = u.ebeMultiply(v)"
    Then the operation should complete successfully without throwing "ConcurrentModificationException"
    And the result "w" should be a zero vector (all entries removed or zero)

  Scenario: Element-by-element division resulting in entry removal
    Given a vector "v_inf" with dimension 3 and entries:
      | index | value    |
      | 0     | Infinity |
      | 2     | Infinity |
    When I perform element-by-element division "w = u.ebeDivide(v_inf)"
    Then the operation should complete successfully without throwing "ConcurrentModificationException"
    And the result "w" should be a zero vector
