Feature: Exception Message Formatting

  Scenario: Prevent duplicate location information in Map key deserialization errors
    Given a JSON input "{\"value\":\"foo\"}"
    And a target type Map<Enum, Integer> where the Enum key does not contain "value"
    When the JSON is deserialized
    Then a MismatchedInputException should be thrown
    And the exception message should contain the text "at [Source" exactly once

