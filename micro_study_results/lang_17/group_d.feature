Feature: XML Escaping

  Scenario: Escaping a string containing supplementary characters
    Given an input string containing the supplementary character "\ud842\udfb7" followed by "A"
    When the string is escaped for XML
    Then the escaped string should be equal to the original input string
