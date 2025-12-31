Feature: MultiKey Serialization Support

  Scenario: MultiKey works correctly as a Map key after serialization
    Given a key object "sysKey" with a hash code that changes after serialization
    And a MultiKey "mk1" created with "sysKey"
    And a Map "map1" containing "mk1" mapped to "value1"
    When "map1" is serialized and deserialized to "map2"
    And "sysKey" is retrieved from the deserialized stream as "sysKey2"
    And a new MultiKey "mk2" is created with "sysKey2"
    Then "map2" should contain "mk2"
    And getting "mk2" from "map2" should return "value1"
