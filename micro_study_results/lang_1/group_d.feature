Feature: Hexadecimal number parsing in NumberUtils

  As a user of NumberUtils
  I want to parse hexadecimal string representations of numbers
  So that they are correctly converted to the narrowest fitting numeric type without overflow

  Scenario Outline: Parsing hexadecimal strings that fit within Integer range
    Given a hexadecimal string "<input>"
    When createNumber is called with "<input>"
    Then the result should be an Integer with value <expected_value>

    Examples:
      | input        | expected_value |
      | 0x8000       | 32768          |
      | 0x7FFFFFFF   | 2147483647     |
      | 0x08000000   | 134217728      |
      | 0x007FFFFFFF | 2147483647     |

  Scenario Outline: Parsing hexadecimal strings exceeding Integer range into Long
    Given a hexadecimal string "<input>"
    When createNumber is called with "<input>"
    Then the result should be a Long with value <expected_value>

    Examples:
      | input               | expected_value      |
      | 0x80000000          | 2147483648          |
      | 0xFFFFFFFF          | 4294967295          |
      | 0x080000000         | 2147483648          |
      | 0x00FFFFFFFF        | 4294967295          |
      | 0x800000000         | 34359738368         |
      | 0x7FFFFFFFFFFFFFFF  | 9223372036854775807 |
      | 0x07FFFFFFFFFFFFFFF | 9223372036854775807 |

  Scenario Outline: Parsing hexadecimal strings exceeding Long range into BigInteger
    Given a hexadecimal string "<input>"
    When createNumber is called with "<input>"
    Then the result should be a BigInteger with value "<expected_value>"

    Examples:
      | input                  | expected_value       |
      | 0x8000000000000000     | 9223372036854775808  |
      | 0xFFFFFFFFFFFFFFFF     | 18446744073709551615 |
      | 0x00008000000000000000 | 9223372036854775808  |
      | 0x0FFFFFFFFFFFFFFFF    | 18446744073709551615 |
