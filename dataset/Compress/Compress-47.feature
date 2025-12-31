Feature: ZipArchiveInputStream Capability Check

  Scenario: Properly mark entries as unreadable if uncompressed size is unknown for specific compression methods
    Given a ZipArchiveInputStream is created with an empty input stream
    And a ZipArchiveEntry is created with name "test"
    When the entry method is set to BZIP2 and the compressed size is unknown
    Then checking if the entry data can be read should return false
    When the entry method is set to DEFLATED and the compressed size is unknown
    Then checking if the entry data can be read should return true
    When the entry method is set to ENHANCED_DEFLATED and the compressed size is unknown
    Then checking if the entry data can be read should return true
