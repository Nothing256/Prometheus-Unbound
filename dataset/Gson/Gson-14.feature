Feature: Wildcard Type Simplification
  As a developer using Gson
  I want wildcard types to be simplified when nested
  So that I avoid infinite recursion and stack overflow errors during type resolution

  Scenario: Creating a supertype of a wildcard that is already a supertype
    Given the type is "? super java.lang.Number"
    When I request a supertype of this type
    Then the result should be "? super java.lang.Number"

  Scenario: Creating a subtype of a wildcard that is already a subtype
    Given the type is "? extends java.lang.Number"
    When I request a subtype of this type
    Then the result should be "? extends java.lang.Number"

  Scenario: Creating a supertype of a wildcard that is a subtype
    Given the type is "? extends java.lang.Number"
    When I request a supertype of this type
    Then the result should be "?"

  Scenario: Creating a subtype of a wildcard that is a supertype
    Given the type is "? super java.lang.Number"
    When I request a subtype of this type
    Then the result should be "?"
