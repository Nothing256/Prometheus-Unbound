Feature: UnboundedFifoBuffer Serialization

  Scenario: Adding an element to a deserialized empty UnboundedFifoBuffer
    Given an empty UnboundedFifoBuffer
    When the buffer is serialized and deserialized
    And an element "Foo" is added to the buffer
    Then the size of the buffer should be 1
    And the buffer should not be empty
