Feature: EventState Robustness

  Scenario: Event detected slightly before the actual root
    Given an event handler for a function g(t) = (t - 90) * (135 - t)
    And the event detection tolerance is 0.1
    And a previous event at r1 = 90.0 was accepted at t0 = 89.999 (where g(t0) is still negative)
    And the logical state indicates the function is increasing (positive) after the event
    When the event state evaluates a step from t0 to t1 = 153.1
    Then the system should recognize the sign change for the next event at r2 = 135.0
    And the root solver should not fail with "function values at endpoints do not have different signs"
    And the next event should be detected near 135.0
