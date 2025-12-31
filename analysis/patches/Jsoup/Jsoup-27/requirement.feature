Feature: Charset Extraction from Content-Type Header

  Scenario: Extract supported charset without enforcing uppercase
    The system currently incorrectly uppercases the extracted charset (e.g., "utf-8" becomes "UTF-8").
    The requirement is to preserve the casing as found in the header, provided it is a supported charset.

    Given the Content-Type header is "text/html;charset=utf-8 "
    When the charset is extracted
    Then the result should be "utf-8"

  Scenario: Handle quoted supported charset
    Given the Content-Type header is "text/html; charset=\"utf-8\""
    When the charset is extracted
    Then the result should be "utf-8"

  Scenario: Return null for unsupported or unknown charset
    The system currently returns the uppercased name of the unknown charset (e.g., "UNKNOWN").
    The requirement is to validate the charset and return null if it is not supported by the JVM.

    Given the Content-Type header is "text/html;charset=Unknown"
    When the charset is extracted
    Then the result should be null

  Scenario: Return null for unsupported quoted charset
    Given the Content-Type header is "text/html; charset=\"Unsupported\""
    When the charset is extracted
    Then the result should be null

