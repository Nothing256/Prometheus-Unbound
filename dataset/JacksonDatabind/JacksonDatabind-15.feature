Feature: Handling of untyped return values from Converters during Serialization

  The system should correctly serialize objects returned by a Converter even if the Converter's 
  declared return type is generic (e.g., java.lang.Object). In such cases, the serializer 
  should determine the actual runtime type of the converted value and use the appropriate 
  serializer, rather than failing or using a generic serializer for Object.

  Scenario: Serialize a bean using a Converter that declares return type as Object (Issue #731)
    Given a POJO "ConvertingBeanWithUntypedConverter" is defined with fields "x" and "y"
    And this POJO is annotated to use "UntypedConvertingBeanConverter" for serialization
    And the "UntypedConvertingBeanConverter" declares a return type of "java.lang.Object"
    But the "UntypedConvertingBeanConverter" actually returns an instance of "DummyBean"
    And "DummyBean" has valid public properties "a" and "b"
    When I serialize an instance of "ConvertingBeanWithUntypedConverter" with x=1 and y=2
    Then the serialization should not fail with "No serializer found"
    And the resulting JSON should match '{"a":2,"b":4}'
