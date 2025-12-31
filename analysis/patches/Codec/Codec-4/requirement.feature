Feature: Base64 Default Constructor Behavior

  Scenario: Default constructor defaults to unchunked encoding
    Given I have a Base64 instance created with the default constructor
    When I encode a byte array containing {-72}
    Then the encoded result should be "uA=="
    And the encoded result should not be "uA==\r\n"
