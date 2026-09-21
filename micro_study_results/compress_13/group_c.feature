Feature: Normalization of backslashes in Zip entry names

  Scenario: Normalize directory entry names with trailing backslash read from stream
    Given a zip archive created on a Windows system with entry path 'ä\'
    When entries are read using ZipArchiveInputStream
    Then the entry name should be normalized to "ä/"

  Scenario: Normalize file entry paths with backslashes accessed via ZipFile
    Given a zip archive created on a Windows system with entry path "ä\ü.txt"
    When the archive is opened using ZipFile
    Then retrieving the entry by path "ä/ü.txt" should return the entry
    And retrieving the entry by path "ä\ü.txt" should return null
