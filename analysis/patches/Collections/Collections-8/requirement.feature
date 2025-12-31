Feature: UnboundedFifoBuffer Serialization and Growth

  Scenario: Adding elements after deserializing an empty UnboundedFifoBuffer
    Given an empty UnboundedFifoBuffer
    When the buffer is serialized and then deserialized
    And I add the element "Foo" to the buffer
    Then the buffer size should be 1
