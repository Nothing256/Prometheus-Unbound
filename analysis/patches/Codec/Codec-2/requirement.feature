Feature: Base64 Encoding of Empty Input

  Scenario: Encoding an empty input stream with line chunking enabled
    Given I have a Base64InputStream configured for encoding
    And the input stream to be encoded is empty
    And the line length is set to 76
    And the line separator is set to CRLF
    When I read from the Base64InputStream
    Then the first byte read should be -1 (EOF)
    And the total number of bytes read should be 0
