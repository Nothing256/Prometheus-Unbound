Feature: Deep Stubs Serialization Support

  Background:
    Given a class "NotSerializableShouldBeMocked" defined as:
      """
      public static class NotSerializableShouldBeMocked {
          NotSerializableShouldBeMocked(String mandatory_param) { }
      }
      """
    And a class "ToBeDeepStubbed" defined as:
      """
      public static class ToBeDeepStubbed {
          public NotSerializableShouldBeMocked getSomething() {
              return null;
          }
      }
      """

  Scenario: Deep stubs should not enforce serialization when the deep stub return type is not serializable
    Given I mock "ToBeDeepStubbed" with "RETURNS_DEEP_STUBS" answer
    When I retrieve the deep stub by calling "getSomething()"
    Then the deep stub should be successfully created
    And no serialization exception should be thrown
