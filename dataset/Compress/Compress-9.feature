Feature: TarArchiveOutputStream Byte Counting

  Background:
    Given a TarArchiveOutputStream writing to a file

  Scenario: accurately count total bytes written including headers and padding
    Given I create a TarArchiveOutputStream
    And I add an archive entry for a file named "test1.xml" with content length 76
    And I write the content of the file to the stream
    And I close the archive entry
    When I close the TarArchiveOutputStream
    Then the value returned by getBytesWritten should equal the total size of the output file
