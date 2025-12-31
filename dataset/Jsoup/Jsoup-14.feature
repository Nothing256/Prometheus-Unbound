Feature: Implicit Closure of RCDATA Elements

  Scenario: A start tag within a textarea implicitly closes the textarea
    Given the tokenizer is in the RCDATA state processing a "textarea" element
    When the input contains "one<p>two"
    Then the "textarea" text content should be "one"
    And the "<p>" tag should be parsed as a sibling element containing "two"

  Scenario: A start tag within a title implicitly closes the title
    Given the tokenizer is in the RCDATA state processing a "title" element
    When the input contains "One<b>Two <p>Test</p>"
    Then the "title" text content should be "One"
    And the "<b>" tag should be parsed as a new element containing "Two "
