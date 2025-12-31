Feature: Correct Handling of Wildcard Types in Map Values

  Scenario: Deserialize Map with wildcard parameterized list value
    Given a Java class structure:
      """
      class SmallClass {
        String inSmall;
      }
      class BigClass {
        Map<String, ? extends List<SmallClass>> inBig;
      }
      """
    And a JSON payload:
      """
      {
        "inBig": {
          "key": [
            { "inSmall": "hello" }
          ]
        }
      }
      """
    When the JSON is deserialized into an instance of BigClass
    Then the entry "key" in the "inBig" map should be a List
    And the first element of that List should be an instance of SmallClass
    And the "inSmall" field of that SmallClass instance should be "hello"
