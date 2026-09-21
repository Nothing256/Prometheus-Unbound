Feature: Escaped quote support in ExtendedMessageFormat

  Scenario: Formatting a pattern with escaped quotes, quoted text, and custom formats
    Given a format registry containing a custom "lower" format factory
    And a pattern "it''s a {0,lower} 'test'!"
    When an ExtendedMessageFormat is created with the pattern and registry
    And the format is applied with argument "DUMMY"
    Then the formatted result should be "it's a dummy test!"
