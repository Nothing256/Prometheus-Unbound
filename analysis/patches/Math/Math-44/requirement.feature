Feature: Correct Event Evaluation Time After Reset

  Scenario: Prevent evaluation of event functions at obsolete times after a state reset
    Given a differential equation with dimension 1
    And a Dormand-Prince 853 integrator with a large initial step size (e.g., 3.0)
    And a resetting event handler "Event1" scheduled at t = 10.99
    And a resetting event handler "Event2" scheduled at t = 11.01
    And "Event2" asserts that it is never evaluated at a time earlier than the last trigger time of "Event1"
    When the equation is integrated from t = 0.0 to t = 30.0
    Then the integration completes successfully
    And the final time is 30.0
    And the assertion in "Event2" is never violated
