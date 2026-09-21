Feature: Object Array to Class Array Conversion

  Scenario: Convert an Object array containing null elements
    Given an Object array containing null elements
    When the array is converted to an array of Class objects
    Then the resulting Class array should contain null at the corresponding positions
    And each non-null element should be replaced with its respective Class
