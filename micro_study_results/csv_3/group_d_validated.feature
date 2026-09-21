Feature: Escaped character handling

  Scenario: Preserve escape character for MySQL null value
    Given a CSV format with escape character '\'
    When the CSV input "character\NEscaped" is parsed
    Then the parsed value should be "character\NEscaped"

  Scenario: Preserve escape character for non-escapable character
    Given a CSV format with escape character '\'
    When the CSV input "character\aEscaped" is parsed
    Then the parsed value should be "character\aEscaped"

  Scenario: Preserve escape character preceding non-meta characters
    Given a CSV format with delimiter ',', quote character "'", and escape character '/'
    When the CSV input '   8   ,   "quoted "" /" // string"   ' is parsed
    Then field 1 should be "   8   "
    And field 2 should be '   "quoted "" /" / string"   '
