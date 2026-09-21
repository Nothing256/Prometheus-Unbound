Feature: ExtendedMessageFormat with escaped single quotes

  Scenario: Format pattern containing escaped single quotes and custom format elements
    Given a format registry containing a "lower" format factory
    And a pattern "it''s a {0,lower} 'test'!"
    When an ExtendedMessageFormat is created with the pattern and registry
    And the message is formatted with the argument "DUMMY"
    Then the formatted result should be "it's a dummy test!"
