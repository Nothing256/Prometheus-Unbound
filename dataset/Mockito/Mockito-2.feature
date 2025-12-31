Feature: Timer Duration Validation

  Scenario: Prevent creating a Timer with negative duration
    Given I try to create a new Timer
    When I provide a negative duration of -1 milliseconds
    Then the operation should fail
    And a FriendlyReminderException should be thrown indicating that negative duration is forbidden