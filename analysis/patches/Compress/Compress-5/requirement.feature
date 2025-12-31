Feature: Handling of truncated entries in ZipArchiveInputStream

  Scenario: Reading data from a truncated ZIP entry
    Given a ZipArchiveInputStream initialized with a truncated ZIP archive
    And the stream is positioned at a truncated entry
    When I attempt to read data from the entry
    Then the read method should throw an IOException with the message "Truncated ZIP file"
