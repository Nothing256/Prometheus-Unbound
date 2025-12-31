Feature: Charset Encoding Fallback

  Scenario: Fallback to UTF-8 when the source charset cannot be used for encoding
    Given an HTML document with a meta charset "ISO-2022-CN"
    And the system supports decoding "ISO-2022-CN" but not encoding it
    When the document is parsed from an input stream
    Then the detected charset for the document should be "UTF-8"
    And the document content should be correctly parsed as "One"
    And the rendered HTML should contain <meta charset="UTF-8">
