Feature: Entity Encoding Handling
  
  Scenario: Handle unencodable characters in Shift_JIS with XHTML escape mode
    Given a document with the content "before&nbsp;after"
    And the document output settings are configured with charset "Shift_JIS"
    And the document output settings are configured with escape mode "xhtml"
    When the document is converted to HTML
    Then the output should not contain the character "?"
    And the output should contain either "&#xa0;" or "&nbsp;"
