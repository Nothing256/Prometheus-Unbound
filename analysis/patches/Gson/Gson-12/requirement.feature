Feature: JsonTreeReader Skip Value Root Handling

  The skipValue method in JsonTreeReader must safely handle cases where the element being skipped is the root element of the document.
  Skipping the root element should result in the reader being exhausted (END_DOCUMENT) without throwing exceptions like ArrayIndexOutOfBoundsException.

  Scenario: Skip an empty root JsonObject
    Given I have a JsonTreeReader initialized with an empty JsonObject
    When I call skipValue
    Then the method should execute without throwing "java.lang.ArrayIndexOutOfBoundsException"
    And the peek method should return "END_DOCUMENT"

  Scenario: Skip a filled root JsonObject
    Given I have a JsonTreeReader initialized with a filled JsonObject containing arrays and nested objects
    When I call skipValue
    Then the method should execute without throwing "java.lang.ArrayIndexOutOfBoundsException"
    And the peek method should return "END_DOCUMENT"
