Feature: XML mapper copy configuration

  Scenario: Serialization with copied mapper when annotations are disabled
    Given an XML mapper
    And a copy of the XML mapper with annotations disabled
    And an instance of a class named "Pojo282" annotated with root element name "AnnotatedName"
    When the instance is serialized using the original XML mapper
    And the instance is serialized using the copied XML mapper
    Then the XML output from the original mapper should have root element "AnnotatedName"
    And the XML output from the copied mapper should have root element "Pojo282"
    And the XML output from the copied mapper should not contain "AnnotatedName"
