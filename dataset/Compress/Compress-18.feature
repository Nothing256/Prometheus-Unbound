Feature: Support for Non-ASCII Directory Names in PAX Headers

  Background:
    Given a TarArchiveOutputStream configured with POSIX compatibility
    And the stream is set to add PAX headers for non-ASCII names

  Scenario: Writing a directory entry with non-ASCII characters in its name
    When I attempt to write a directory entry named "f\u00f6\u00f6/"
    Then the operation should complete without throwing an IOException
    And the entry should be successfully written to the archive
    And the entry should be identified as a directory
    And the entry name should be correctly stored as "f\u00f6\u00f6/"
