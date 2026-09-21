Feature: DerivativeStructure atan2 special cases handling

  Scenario: Computing atan2 for positive zero y and positive zero x
    Given a DerivativeStructure y with value +0.0
    And a DerivativeStructure x with value +0.0
    When atan2 is computed for y and x
    Then the resulting DerivativeStructure value should be +0.0

  Scenario: Computing atan2 for positive zero y and negative zero x
    Given a DerivativeStructure y with value +0.0
    And a DerivativeStructure x with value -0.0
    When atan2 is computed for y and x
    Then the resulting DerivativeStructure value should be PI

  Scenario: Computing atan2 for negative zero y and positive zero x
    Given a DerivativeStructure y with value -0.0
    And a DerivativeStructure x with value +0.0
    When atan2 is computed for y and x
    Then the resulting DerivativeStructure value should be -0.0

  Scenario: Computing atan2 for negative zero y and negative zero x
    Given a DerivativeStructure y with value -0.0
    And a DerivativeStructure x with value -0.0
    When atan2 is computed for y and x
    Then the resulting DerivativeStructure value should be -PI
