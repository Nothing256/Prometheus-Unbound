Feature: Hexadecimal Number Parsing in NumberUtils.createNumber

  The NumberUtils.createNumber method should properly handle hexadecimal numbers
  and return the correct numeric type based on the magnitude of the value,
  ensuring that numbers that exceed Integer range are parsed as Long or BigInteger.

  Scenario: Parsing hexadecimal numbers that exceed Integer maximum value
    Given a hexadecimal string "0x80000000" (which equals 2147483648 in decimal)
    When NumberUtils.createNumber("0x80000000") is called
    Then it should return a Long with value 2147483648L
    And it should not throw a NumberFormatException

  Scenario: Parsing hexadecimal numbers with 8 or fewer digits that fit in Integer range
    Given a hexadecimal string "0x7FFFFFFF" (which equals 2147483647 in decimal)
    When NumberUtils.createNumber("0x7FFFFFFF") is called
    Then it should return an Integer with value 2147483647
    And it should not throw a NumberFormatException

  Scenario: Parsing hexadecimal numbers with 8 or fewer digits that exceed Integer range
    Given a hexadecimal string "0xFFFFFFFF" (which equals 4294967295 in decimal)
    When NumberUtils.createNumber("0xFFFFFFFF") is called
    Then it should return a Long with value 4294967295L
    And it should not throw a NumberFormatException

  Scenario: Parsing hexadecimal numbers with 9-16 digits
    Given a hexadecimal string "0x800000000" (which has 9 hex digits)
    When NumberUtils.createNumber("0x800000000") is called
    Then it should return a Long
    And it should not throw a NumberFormatException

  Scenario: Parsing hexadecimal numbers with more than 16 digits
    Given a hexadecimal string "0x80000000000000000" (which has 17 hex digits)
    When NumberUtils.createNumber("0x80000000000000000") is called
    Then it should return a BigInteger
    And it should not throw a NumberFormatException

  Scenario: Parsing hexadecimal numbers with leading zeros
    Given a hexadecimal string "0x080000000" (which equals 0x80000000 with leading zero)
    When NumberUtils.createNumber("0x080000000") is called
    Then it should return a Long with value 2147483648L
    And it should not throw a NumberFormatException