Feature: Zip Archive Output Stream Raw Entry Handling

  Scenario: Adding a raw entry with known CRC and size to an unseekable output stream
    Given a ZipArchiveOutputStream writing to an unseekable stream
    When I add a raw archive entry where the CRC, Size, and Compressed Size are already known
    Then the resulting Zip entry in the archive should not have the Data Descriptor flag (bit 3) set in the General Purpose Bit field of the Local File Header
    And the Local File Header should contain the correct CRC, Compressed Size, and Original Size values instead of zeros
    And no Data Descriptor record should be written after the entry data
