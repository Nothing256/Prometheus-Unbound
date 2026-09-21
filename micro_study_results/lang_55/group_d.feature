Feature: StopWatch suspend and stop

  Scenario: Stopping a suspended stopwatch does not include suspended time
    Given a stopwatch has been started
    And some time has elapsed
    And the stopwatch is suspended
    And the suspend time is recorded
    When time elapses while the stopwatch is suspended
    And the stopwatch is stopped
    Then the total time should equal the recorded suspend time
