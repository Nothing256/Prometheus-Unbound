Feature: TypeFactory handling of java.util.Properties

  Scenario: Converting a POJO with non-String fields to Properties
    Given a POJO with an Integer field "A" having value 129
    And a String field "B" having value "13"
    When the POJO is converted to an instance of "java.util.Properties"
    Then the "Properties" instance should contain key "A" with String value "129"
    And the "Properties" instance should contain key "B" with String value "13"
    And calling "getProperty" on the Properties instance with key "A" should return "129"
