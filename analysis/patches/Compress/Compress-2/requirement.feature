Feature: AR Archive Input Stream Logic

  Background:
    Given an AR archive file created with standard AR headers and entries

  Scenario: Reading an AR archive containing valid entries
    Given an AR archive "bla2.ar" with a valid global header
    And the archive contains exactly one entry named "test1.xml" with content
    When I attempt to read the next entry from the stream
    Then the system should return the entry with name "test1.xml"
    And the system should not return null immediately after reading the global header
    And the subsequent attempt to read an entry should return null

  Scenario: Handling End of File
    Given the last entry of the archive has been read
    When I attempt to read the next entry
    Then the system should return null indicating the end of the archive
    And the system should not throw an exception for a valid EOF
