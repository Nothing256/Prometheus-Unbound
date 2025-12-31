Feature: Handle Null Object Id during Deserialization

  Scenario: Deserialization of an object with a null Object Id property
    Given a POJO "Identifiable" configured with "@JsonIdentityInfo"
    And the JSON payload represents an instance of "Identifiable"
    And the JSON payload explicitly sets the Object Id property "id" to null
    When the content is deserialized
    Then the deserialization should succeed without throwing an exception
    And the returned object should not be null
    And the Object Id value should be treated as missing
