Feature: WinZip backslash workaround for ZIP entry names

  Scenario: Normalize backslashes to forward slashes when looking up entries in ZipFile
    Given a ZIP archive containing an entry with backslashes in its path
    When the archive is loaded using ZipFile
    Then querying for the entry using the backslash path "ä\ü.txt" should return null
    And querying for the entry using the normalized path "ä/ü.txt" should return the entry

  Scenario: Normalize backslashes to forward slashes when reading entries from ZipArchiveInputStream
    Given a ZIP archive containing a directory entry ending with a backslash
    When entries are read from the archive using ZipArchiveInputStream
    Then the directory entry name should be normalized to end with a forward slash "ä/"
