Feature: Escaping non-meta characters in CSV parsing

  Scenario: Preserve escape character for MySQL null indicator sequence
    Given a CSV format with escape character '\'
    When parsing the CSV input "character\NEscaped"
    Then the parsed field value should be "character\NEscaped"

  Scenario: Preserve escape character for arbitrary character
    Given a CSV format with escape character '\'
    When parsing the CSV input "character\aEscaped"
    Then the parsed field value should be "character\aEscaped"

  Scenario: Preserve escape character before non-meta characters with custom escape and quote characters
    Given a CSV format with delimiter ',', quote character "'", and escape character '/'
    When parsing the CSV input:
      """
         8   ,   "quoted "" /" // string"   
      """
    Then the second field value should be:
      """
         "quoted "" /" / string"   
      """
