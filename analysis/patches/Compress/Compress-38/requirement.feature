Feature: TarArchiveEntry Directory Logic for Pax Headers

  The TarArchiveEntry directory detection logic must exclude Pax headers, even if their names end in a slash,
  to ensure that the InputStream correctly reads the header metadata instead of skipping it.

  Scenario: Pax Extended Header ('x') with trailing slash is not a directory
    Given a TarArchiveEntry with name "pax-header/"
    And the entry link flag is 'x' (Pax Extended Header)
    When isDirectory is called
    Then it should return false

  Scenario: Pax Global Extended Header ('g') with trailing slash is not a directory
    Given a TarArchiveEntry with name "pax-global-header/"
    And the entry link flag is 'g' (Global Pax Extended Header)
    When isDirectory is called
    Then it should return false

  Scenario: SunOS Pax Extended Header ('X') with trailing slash is not a directory
    Given a TarArchiveEntry with name "pax-sunos-header/"
    And the entry link flag is 'X' (SunOS Pax Extended Header)
    When isDirectory is called
    Then it should return false
