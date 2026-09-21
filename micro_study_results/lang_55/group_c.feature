Feature: StopWatch timing

  Scenario: Stopping a suspended stopwatch preserves the suspended elapsed time
    Given a stopwatch is started
    And the stopwatch is suspended after running for a period of time
    When time elapses while the stopwatch remains suspended
    And the stopwatch is stopped
    Then the total time recorded by the stopwatch should equal the time recorded when it was suspended
