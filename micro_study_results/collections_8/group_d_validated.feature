Feature: UnboundedFifoBuffer Serialization

  Scenario: Adding an element to a deserialized empty buffer
    Given an empty UnboundedFifoBuffer
    When the buffer is serialized and deserialized
    And an element "Foo" is added to the buffer
    Then the buffer size should be 1
