Feature: RFC 7159 Compliance for Top-level Values

  The JsonReader should support parsing any valid JSON value at the top level, 
  including primitives (booleans, numbers, strings) and null, as specified by RFC 7159.
  This behavior must be supported in strict mode (default).

  Scenario: Skip top-level boolean value
    Given a JsonReader initialized with "true"
    When skipValue is called
    Then the next token should be END_DOCUMENT
