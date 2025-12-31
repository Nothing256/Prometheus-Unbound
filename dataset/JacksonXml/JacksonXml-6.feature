Feature: Handling of Empty Binary Streams in XML Serialization

  Scenario: Serializing a POJO with an empty DirectByteBuffer field
    Given a POJO with a field "field" of type ByteBuffer
    And the ByteBuffer is empty (contains 0 bytes)
    And the ByteBuffer is a DirectByteBuffer (which triggers stream-based processing)
    When the POJO is serialized to XML
    Then the resulting XML should be "<TestPojo><field/></TestPojo>"
