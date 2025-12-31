Feature: Tar Archive Checksum Verification and Detection

  Scenario: Detect Tar archive with 7-digit checksum
    Given a Tar archive file "COMPRESS-335.tar"
    And the archive header does not contain the "ustar" magic signature
    And the archive header contains a checksum field "0016055\0" consisting of 7 octal digits followed by a NUL
    When the archive type is detected using the ArchiveStreamFactory
    Then the detection should successfully identify the stream as "tar"
    And the checksum verification logic should correctly parse and validate the 7-digit checksum
