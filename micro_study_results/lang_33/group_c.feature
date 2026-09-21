Feature: Convert Object Array to Class Array

  Scenario: Convert an Object array containing null elements to a Class array
    Given an array of Objects containing "Test", null, and 99.0
    When the array of Objects is converted to an array of Classes
    Then the resulting array should contain String.class, null, and Double.class
