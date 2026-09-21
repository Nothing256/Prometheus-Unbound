Feature: XML Mapper copy configuration isolation

  Scenario: Copied XmlMapper with disabled annotations does not use annotated root name
    Given an XmlMapper with annotations enabled
    And a copy of the XmlMapper configured with annotations disabled
    And an instance of a class named "Pojo282" annotated with root element name "AnnotatedName"
    When the instance is serialized with the original XmlMapper
    Then the serialized XML should use "AnnotatedName" as the root element name
    When the instance is serialized with the copied XmlMapper
    Then the serialized XML should use "Pojo282" as the root element name and not "AnnotatedName"
