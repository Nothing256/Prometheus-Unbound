Feature: ZipArchiveEntry Name Normalization

  In order to ensure consistent behavior when handling Zip archives created on Windows (e.g., by WinZip)
  As a user of the Commons Compress library
  I want backslashes in ZipArchiveEntry names to be treated as directory separators and normalized to forward slashes

  Scenario: Entry name containing backslashes is normalized
    Given a Zip archive containing an entry with the name "folder\file.txt"
    When the entry is read using ZipArchiveInputStream
    Then the entry name should be normalized to "folder/file.txt"
    And the getName() method should return "folder/file.txt"

  Scenario: Setting entry name with backslashes manually
    Given a new ZipArchiveEntry is created
    When the name is set to "my\path\to\file"
    Then the stored name should be "my/path/to/file"

