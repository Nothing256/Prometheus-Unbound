Feature: Safe consumption at End of File
  As a developer using Jsoup
  I want the CharacterReader to handle consumption requests gracefully when at the end of the file
  So that I don't encounter exceptions like StringIndexOutOfBoundsException

  Scenario: Consuming to a non-existent character when already at the end
    Given a CharacterReader initialized with "<!"
    And the sequence "<!" has been consumed
    When I attempt to consume to '>'
    Then the result should be an empty string
    And the reader should be empty
