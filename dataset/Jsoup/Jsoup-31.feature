Feature: XML Declaration Parsing
  As a user of the XML parser
  I want XML declarations to be correctly identified and parsed as XmlDeclaration nodes
  So that they are preserved in the document structure and serialized correctly, distinct from comments.

  Scenario: Parse an XML Declaration correctly
    Given the XML input "<?xml encoding='UTF-8' ?><body>One</body><!-- comment -->"
    When the content is parsed using the XML parser
    Then the resulting document should contain an XmlDeclaration node as the first child
    And the XmlDeclaration node name should be "#declaration"
    And the serialized document outer HTML should be "<?xml encoding='UTF-8' ?> <body> One </body> <!-- comment -->"
    And the declaration should not be serialized as a comment like "<!--?xml encoding='UTF-8' ?-->"
