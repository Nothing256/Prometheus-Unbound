Feature: Resilience to truncated BZip2 streams

  Background:
    Given a BZip2 stream containing a single compressed block of data
    And the stream is truncated immediately after the block data, missing the EOS magic and CRC

  Scenario: Reading the full content of a truncated block
    When I read the expected number of uncompressed bytes from the stream
    Then I should receive all the uncompressed data matching the original content
    And the read operation should not throw an "unexpected end of stream" exception during the read of valid data
