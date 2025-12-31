Feature: Robust XML Declaration Parsing in Comments

  In order to prevent parser crashes when encountering ambiguous or malformed XML-like structures
  As a library user
  I want the Comment to XmlDeclaration conversion to be robust and handle non-element content gracefully

  Scenario: Attempting to convert a comment to an XML Declaration when the content is not a valid element
    Given a Comment node with data "?\"; var b=\""
    When I attempt to convert it to an XML Declaration using asXmlDeclaration
    Then the result should be null
    And no exception should be thrown

  Scenario: Parsing a script tag containing characters that look like an XML declaration
    Given the input XML is "<script> var a=\"<?\"; var b=\"?>\"; </script>"
    When I parse the input using the XML parser
    Then the parsing should succeed without errors
    And the resulting document should contain a script element
    And the script content should contain a comment node with the original data

