Feature: Base64 InputStream Encoding Robustness

  Scenario: Encode data when the internal buffer is initialized to a size smaller than the encoding quantum
    Given a Base64InputStream is configured to encode data
    And the underlying input stream returns 3 bytes of data (e.g., three newline characters)
    And the Base64InputStream reads from the underlying stream using a 1-byte buffer, forcing the internal buffer to be reset to 1 byte
    When I read from the Base64InputStream 5 times
    Then the first 4 reads should return the expected Base64 characters (e.g., 'C', 'g', 'o', 'K')
    And the 5th read should return -1 indicating EOF
    And the process should not fail with an ArrayIndexOutOfBoundsException due to insufficient buffer resizing
