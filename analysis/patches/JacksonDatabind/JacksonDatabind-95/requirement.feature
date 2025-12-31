Feature: TypeFactory Canonical Name Handling

  Scenario: Constructing a JavaType from a raw canonical string for a Collection
    Given I have a default TypeFactory
    When I construct a type from the canonical string "java.util.List"
    Then the resulting type should be an instance of "com.fasterxml.jackson.databind.type.CollectionType"
    And the raw class of the type should be "java.util.List"
    And the content type of the type should be "java.lang.Object"
    And the canonical string of the type should be "java.util.List<java.lang.Object>"
    And constructing a type from "java.util.List<java.lang.Object>" should yield a type equal to the original type
