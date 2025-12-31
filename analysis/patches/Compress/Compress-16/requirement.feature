Feature: Archive Stream Factory Auto-detection

  As a developer using Commons Compress
  I want the ArchiveStreamFactory to correctly identify archive formats
  So that I don't process non-archive files as archives

  Scenario: AIFF files should not be misidentified as TAR archives
    Given an input stream from the file "src/test/resources/testAIFF.aif"
    When I attempt to create an archive input stream from the input stream
    Then an ArchiveException should be thrown
    And the exception message should start with "No Archiver found"

  Scenario: TAR detection MUST verify header checksum
    Given an input stream with 512 bytes that parses as a TAR header but has an invalid checksum
    When I attempt to create an archive input stream from the input stream
    Then an ArchiveException should be thrown
    And the exception message should start with "No Archiver found"
