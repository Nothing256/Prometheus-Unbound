Feature: JsonReader Lenient Number Parsing

  Background:
    Given a JsonReader is configured to be lenient
    And the input JSON contains a Map with unquoted numeric keys

  Scenario: Parsing an unquoted integer key promoted to a value
    Given the JSON input is "{123:\"value\"}"
    When the name "123" is promoted to a value
    And nextInt() is called
    Then it should return the integer 123

  Scenario: Parsing an unquoted long key promoted to a value
    Given the JSON input is "{9876543210:\"value\"}"
    When the name "9876543210" is promoted to a value
    And nextLong() is called
    Then it should return the long 9876543210
