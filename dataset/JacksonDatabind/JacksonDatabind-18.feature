Feature: MappingIterator Recovery from Deserialization Errors

  Scenario: Recovering from a schema mismatch in the middle of a sequence
    The MappingIterator should be able to skip the remainder of a JSON value 
    that caused a deserialization error, allowing the application to continue 
    reading subsequent values in the stream.

    Given a JSON input stream containing a sequence of objects:
      """
      {'a':3}{'a':27,'foo':[1,2],'b':{'x':3}}  {'a':1,'b':2} 
      """
    And a target POJO "Bean" with fields "a" and "b"
    When I read the sequence using MappingIterator<Bean>
    Then the first read returns a Bean with a=3
    And the second read throws a JsonMappingException due to unknown field "foo"
    And the third read successfully returns a Bean with a=1 and b=2
    And hasNextValue returns false
