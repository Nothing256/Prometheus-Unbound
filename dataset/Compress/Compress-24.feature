Feature: Permissive Parsing of Octal Fields

  Legacy and non-compliant Tar implementations may fill the entire octal field 
  with digits, omitting the required trailing space or NUL delimiter. 
  The parser must support this behavior.

  Scenario: Parse an octal field that is fully occupied by digits
    Given a byte buffer of length 12 populated with the ASCII string "777777777777"
    When TarUtils.parseOctal is executed on this buffer
    Then the parsed value should be 68719476735
