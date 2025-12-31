Feature: JsonIdentityReference on Class Level

  Support @JsonIdentityReference(alwaysAsId=true) on the class definition itself,
  so that all usages of that class are serialized as IDs by default, ensuring consistency
  and reducing the need for repetitive annotations on every property.

  Scenario: Serialize field where the type has @JsonIdentityReference(alwaysAsId=true)
    Given a class "ValueViaClass" annotated with @JsonIdentityInfo and @JsonIdentityReference(alwaysAsId=true)
    And a container class "Container" with a field "alwaysClass" of type "ValueViaClass"
    And the "ValueViaClass" instance has an ID of 1
    When I serialize an instance of "Container" containing this "ValueViaClass" instance
    Then the output JSON for "alwaysClass" should be the ID value 1
    And the output JSON should not contain the full object properties for "alwaysClass"
