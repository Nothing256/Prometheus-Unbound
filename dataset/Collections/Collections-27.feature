Feature: MultiValueMap Deserialization Validation

  Scenario: Prevent deserialization when ReflectionFactory uses a non-Collection class
    Given a MultiValueMap configured with a ReflectionFactory for the class "java.lang.String"
    When I serialize and attempt to deserialize this map
    Then the deserialization should throw an "java.lang.UnsupportedOperationException"
