Feature: CSV Escape Surrogate Pairs
  As a developer using StringEscapeUtils,
  I want the CSV escape functionality to correctly handle surrogate pairs (Unicode characters that require two chars like emojis),
  So that multi-byte Unicode characters are preserved during CSV escaping without throwing exceptions.

  Scenario: CSV escape preserves surrogate pairs without modification
    Given a string containing a surrogate pair character like an emoji "\uD83D\uDE30" (grinning face with smiling eyes)
    When I escape the string using StringEscapeUtils.escapeCsv()
    Then the output should be exactly the same as the input "\uD83D\uDE30"
    And no StringIndexOutOfBoundsException should be thrown during the escaping process

  Scenario: CSV escape handles various surrogate pairs correctly without errors
    Given strings containing different surrogate pairs:
      | "\uD800\uDC00" (example from UTF-16 specification) |
      | "\uD834\uDD1E" (musical symbol g clef)           |
      | "\uDBFF\uDFFD" (high range surrogate pair)       |
    When I escape each string using StringEscapeUtils.escapeCsv()
    Then each output should be exactly the same as its respective input
    And no StringIndexOutOfBoundsException should be thrown during processing

  Scenario: CSV escape with surrogate pairs surrounded by regular content
    Given a string containing surrogate pairs mixed with regular characters "prefix\uD83D\uDE30suffix"
    When I escape the string using StringEscapeUtils.escapeCsv()
    Then the output should preserve the surrogate pair within the string "prefix\uD83D\uDE30suffix"
    And no StringIndexOutOfBoundsException should be thrown during the escaping process

  Scenario: Bug case - CSV escape should correctly report consumed code points for surrogate pairs
    Given a string with a surrogate pair "\uD83D\uDE30" that doesn't contain CSV special characters
    When the CsvEscaper processes this string as part of the translation chain
    Then it should return the correct number of code points consumed (1) rather than char count (2)
    So that the parent translator doesn't attempt to process incomplete surrogate halves
    And no StringIndexOutOfBoundsException occurs