Feature: CPIO Archive Mode Validation

  Scenario: Accepting CPIO entries with missing file type bits
    Some CPIO creators (like Redline RPM) set permission bits in the mode but leave the file type bits as zero.
    The validation logic should be flexible enough to allow this.

    Given I have a CPIO archive "redline.cpio" containing an entry with mode 0x1a4 (octal 0644)
    When I attempt to read the entry using CpioArchiveInputStream
    Then the entry should be returned successfully
    And the entry count should be 1
