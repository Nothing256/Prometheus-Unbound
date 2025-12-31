Feature: Cleaner Robustness

  Scenario: Cleaning a frameset document that lacks a body element
    Given the input HTML is:
      """
      <html><head><script></script><noscript></noscript></head><frameset><frame src="foo" /><frame src="foo" /></frameset></html>
      """
    And the HTML is parsed into a Document
    And a Cleaner is configured with a basic Whitelist
    When the document is cleaned
    Then the resulting document should not be null
    And the resulting document should have an empty body
