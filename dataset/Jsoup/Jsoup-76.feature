Feature: Ignore Initial Newline in Pre Tags

  The HTML parser must ignore a newline character (LF) that immediately follows a <pre> start tag.
  This behavior is specified in the HTML standard to aid authoring.

  Scenario: A single newline after pre tag is ignored
    Given the input HTML is "<pre>\nOne</pre>"
    When the HTML is parsed
    Then the "pre" element should have text "One"

  Scenario: Only the first newline after pre tag is ignored
    Given the input HTML is "<pre>\n\nOne</pre>"
    When the HTML is parsed
    Then the "pre" element should have whole text "\nOne"

  Scenario: Newline is not ignored if not immediately after pre tag
    Given the input HTML is "<pre><!-- comment -->\nOne</pre>"
    When the HTML is parsed
    Then the "pre" element should have whole text "\nOne"

