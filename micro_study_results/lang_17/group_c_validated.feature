Feature: XML Escaping for Supplementary Characters

  Scenario: Escape XML string with supplementary character and subsequent character
    Given an input string "\ud842\udfb7A" containing a supplementary character followed by "A"
    When the string is escaped using StringEscapeUtils escapeXml
    Then the escaped string should be "\ud842\udfb7A"
