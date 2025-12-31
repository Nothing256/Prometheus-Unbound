Feature: Binary Content Detection

  Scenario: Throw IOException when parsing binary content with ignoreContentType enabled
    Given a connection to a binary resource like "/htmltests/thumb.jpg"
    And the connection is configured to ignore content type with ignoreContentType(true)
    When the connection is executed and the response is parsed
    Then an IOException should be thrown with the message "Input is binary and unsupported"

  Scenario: Throw IOException when parsing binary content masquerading as text
    Given a connection to a binary resource like "/htmltests/thumb.jpg"
    And the server response incorrectly sets Content-Type to "text/html"
    When the connection is executed and the response is parsed
    Then an IOException should be thrown with the message "Input is binary and unsupported"
