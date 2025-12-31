Feature: ZipArchiveEntry Unix Symlink Identification

  The isUnixSymlink method should strictly identify Unix symbolic links by ensuring the file type
  bits in the Unix mode correspond exactly to a symbolic link, avoiding false positives when
  invalid or multiple file type bits are set.

  Scenario: Entry with multiple file type flags set should not be considered a symlink
    Given a ZipArchiveEntry with a Unix mode of 0160000
    # 0160000 corresponds to LINK_FLAG (0120000) | DIR_FLAG (040000)
    When I check if the entry is a Unix symlink
    Then the result should be false
