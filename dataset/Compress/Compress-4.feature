Feature: Jar Archive Output Stream

  Scenario: Writing a Jar Archive with JarMarker
    Given I create a JarArchiveOutputStream
    When I add a first entry named "foo/"
    And I add a second entry named "bar/"
    And I finish and close the stream
    Then the created archive should be valid and readable by ZipFile
    And the entry "foo/" should contain the JarMarker extra field
    And the entry "bar/" should not contain the JarMarker extra field