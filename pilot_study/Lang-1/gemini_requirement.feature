Feature: Create Number from String
  As a user of the NumberUtils library
  I want to convert a string representation of a number into the correct Number object
  So that I can work with various numerical types dynamically.

  Scenario: Convert a valid integer string
    Given a string "12345"
    When I call createNumber with the string
    Then the result should be an Integer with the value 12345

  Scenario: Convert a valid long string
    Given a string "12345678901"
    When I call createNumber with the string
    Then the result should be a Long with the value 12345678901

  Scenario: Convert a valid float string
    Given a string "1.23f"
    When I call createNumber with the string
    Then the result should be a Float with the value 1.23

  Scenario: Convert a valid double string
    Given a string "4.56d"
    When I call createNumber with the string
    Then the result should be a Double with the value 4.56

  Scenario: Convert a valid hexadecimal string to an Integer
    Given a string "0x7FFFFFFF"
    When I call createNumber with the string
    Then the result should be an Integer with the value 2147483647

  Scenario: Convert a hexadecimal string that overflows an Integer to a Long
    Given a string "0x80000000"
    When I call createNumber with the string
    Then the result should be a Long with the value 2147483648

  Scenario: Convert a hexadecimal string that overflows a Long to a BigInteger
    Given a string "0x8000000000000000"
    When I call createNumber with the string
    Then the result should be a BigInteger with the value 9223372036854775808

  Scenario: Handle invalid number string
    Given a string "--1.1E-700F"
    When I call createNumber with the string
    Then a NumberFormatException should be thrown
