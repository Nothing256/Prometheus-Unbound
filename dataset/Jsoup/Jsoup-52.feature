Feature: XML Declaration Serialization

  Scenario: Serialize XML Declaration with correct closing delimiter
    Given an XML document with root element "root" and text "node"
    And the document has no existing XML declaration
    When the meta charset element update is enabled
    And the document charset is set to "UTF-8"
    Then the generated XML declaration should be "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
    And the document output should start with the XML declaration
