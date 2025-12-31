Feature: ZipArchiveInputStream Strict Validation

  Scenario: Reading a stream that is not a valid zip archive should throw an exception
    Given a ZipArchiveInputStream is initialized with an input stream containing data that is not a valid zip archive (e.g. an XML file)
    And the stream provides enough data to read a Local File Header
    When I call "getNextEntry" or "getNextZipEntry" to retrieve the first entry
    Then the method should throw a "ZipException" indicating that the stream is not a valid zip archive
