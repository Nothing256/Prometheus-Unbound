Feature: Frequency Value Validation

  In order to ensure correct usage of the Frequency distribution and adhere to the contract for Comparable types
  As a developer using the Frequency class
  I want the addValue method to distinguish between non-comparable objects and objects incompatible with existing values

  Scenario: Adding a non-comparable object to a natural-ordering Frequency
    Given a new Frequency instance created with the default constructor
    When I call addValue with an object that does not implement Comparable
    Then the method should throw a ClassCastException

  Scenario: Adding a comparable object incompatible with existing values
    Given a Frequency instance created with the default constructor
    And the Frequency already contains a value of type Long
    When I call addValue with a value of type String
    Then the method should throw an IllegalArgumentException
