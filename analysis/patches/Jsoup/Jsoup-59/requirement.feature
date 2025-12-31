Feature: Robustness against control characters in attribute names

  In order to parse "rough" HTML found in the wild without crashing
  As a library user
  I want the parser to ignore invalid attribute names created by control characters

  Scenario: Attribute names consisting only of control characters are ignored
    Given the input HTML "<p><a \u0006=foo>One</a><a/\u0006=bar><a foo\u0006=bar>Two</a></p>"
    When the document is parsed
    Then the resulting HTML body should be "<p><a>One</a><a></a><a foo=\"bar\">Two</a></p>"

