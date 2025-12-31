Feature: Type Variable Resolution in Class Hierarchy

  Scenario: Resolve type variables defined in a generic superclass when accessed via a concrete subclass
    Given a generic class "Foo<S, T>" defining fields of type "S" and "T"
    And a concrete subclass "Bar" that extends "Foo<String, Integer>"
    When the system attempts to resolve the actual type of the fields inherited by "Bar"
    Then the type variable "S" should be resolved to "String"
    And the type variable "T" should be resolved to "Integer"
    And the operation should complete without throwing an "UnsupportedOperationException"
