Feature: Hexadecimal string conversion to Number

  Scenario Outline: Parse hexadecimal strings into appropriate numeric types based on magnitude
    Given a hexadecimal string "<input>"
    When the string is converted to a Number
    Then the resulting number should be an instance of "<type>"
    And the resulting number should have value "<value>"

    Examples:
      | input              | type       | value                |
      | 0x7FFFFFFF         | Integer    | 2147483647           |
      | 0x80000000         | Long       | 2147483648           |
      | 0xFFFFFFFF         | Long       | 4294967295           |
      | 0x7FFFFFFFFFFFFFFF | Long       | 9223372036854775807  |
      | 0x8000000000000000 | BigInteger | 9223372036854775808  |
      | 0xFFFFFFFFFFFFFFFF | BigInteger | 18446744073709551615 |

  Scenario Outline: Parse hexadecimal strings with leading zeros without affecting numeric type selection
    Given a hexadecimal string "<input>"
    When the string is converted to a Number
    Then the resulting number should be an instance of "<type>"
    And the resulting number should have value "<value>"

    Examples:
      | input                  | type       | value                |
      | 0x007FFFFFFF           | Integer    | 2147483647           |
      | 0x080000000            | Long       | 2147483648           |
      | 0x00FFFFFFFF           | Long       | 4294967295           |
      | 0x07FFFFFFFFFFFFFFF    | Long       | 9223372036854775807  |
      | 0x00080000000000000    | Long       | 36028797018963968    |
      | 0x00008000000000000000 | BigInteger | 9223372036854775808  |
      | 0x0FFFFFFFFFFFFFFFF    | BigInteger | 18446744073709551615 |
