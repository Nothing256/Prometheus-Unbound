Feature: Correctly handle Unicode Surrogate Pairs during CSV escaping

  The CSV escaping functionality must correctly process Unicode surrogate pairs.
  A surrogate pair consists of two Java `char` units but represents a single
  Unicode code point. The translation logic must correctly count these code points
  to avoid processing errors (such as IndexOutOfBoundsException) and ensure
  data integrity. The system should treat a surrogate pair as one logical character
  when calculating consumption.

  Scenario: Escaping a string containing a single surrogate pair
    Given the input string is "\uD83D\uDE30"
    When the string is escaped for CSV
    Then the result should be "\uD83D\uDE30"

  Scenario: Escaping a string containing multiple different surrogate pairs
    Given the input string is "\uD800\uDC00\uD834\uDD1E"
    When the string is escaped for CSV
    Then the result should be "\uD800\uDC00\uD834\uDD1E"

  Scenario: Escaping a string with surrogate pairs and standard characters
    Given the input string is "A\uDBFF\uDFFDB"
    When the string is escaped for CSV
    Then the result should be "A\uDBFF\uDFFDB"

  Scenario: Escaping a string with surrogate pairs and CSV special characters
    Given the input string is "\uD83D\uDE30,test"
    When the string is escaped for CSV
    Then the result should be "\"\uD83D\uDE30,test\""
