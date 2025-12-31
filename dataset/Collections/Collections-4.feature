Feature: MultiValueMap Put Behavior

  Background:
    Given I have a MultiValueMap

  Scenario: Put returns the value when adding to a new key
    When I put the key "A" with value "a"
    Then the put operation should return "a"
    And the map should contain 1 value for key "A"
    And the total size of the map should be 1

  Scenario: Put returns the value when adding to an existing key
    Given I put the key "A" with value "a"
    When I put the key "A" with value "b"
    Then the put operation should return "b"
    And the map should contain 2 values for key "A"
    And the total size of the map should be 2
