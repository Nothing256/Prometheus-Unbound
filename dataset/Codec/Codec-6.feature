Feature: Base64InputStream Read Compliance

  Scenario: Read method must not return 0 for non-empty buffer request
    Given I have a Base64InputStream wrapping a stream with partial Base64 data "123"
    And I am decoding
    When I call read with a byte array of size 8192
    Then the return value should be either greater than 0 or -1
    And the return value should not be 0