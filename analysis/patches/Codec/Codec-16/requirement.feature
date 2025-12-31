Feature: Base32 Hex Codec Padding and Alphabet Compliance

  Background:
    Given the Base32 Hex alphabet is defined as characters '0'-'9' and 'A'-'V' (RFC 4648)
    And the valid values for these characters are 0-31

  Scenario: Instantiate Base32 Hex codec with a valid padding character 'W'
    The character 'W' is not part of the Base32 Hex alphabet.
    Therefore, it should be accepted as a valid padding character.
    Current buggy behavior mistakenly identifies 'W' as part of the alphabet.

    Given I wish to create a Base32 codec instance
    And I enable the "Hex" variant (Base32 Hex)
    And I select 'W' as the padding byte
    When I instantiate the Base32 codec with these parameters
    Then the instantiation should complete successfully
    And no IllegalArgumentException should be thrown
