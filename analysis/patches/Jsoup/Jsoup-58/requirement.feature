Feature: Strict HTML Validation

  The isValid method should verify that the input HTML is both safe (according to the whitelist)
  and well-formed (contains no parse errors).

  Scenario: Malformed HTML should be invalid even if it contains only whitelisted tags
    Given a body fragment "<p>Test <b><a href='http://example.com/'>OK</b></p>"
    And a basic whitelist
    When I validate the body fragment
    Then the result should be false
