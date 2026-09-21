Feature: Complex addition with NaN values
  As a user of the complex number library
  I want addition involving NaN values to return a NaN complex number
  So that undefined or invalid values are correctly propagated

  Scenario: Adding a complex number with a NaN imaginary part
    Given a complex number with real part 3.0 and imaginary part 4.0
    And a complex number with real part 1.0 and imaginary part NaN
    When the first complex number is added to the second complex number
    Then the resulting complex number should be NaN
    And the real part of the result should be NaN
    And the imaginary part of the result should be NaN

  Scenario: Adding a complex number where the first operand has a NaN part
    Given a complex number with real part 1.0 and imaginary part NaN
    And a complex number with real part 3.0 and imaginary part 4.0
    When the first complex number is added to the second complex number
    Then the resulting complex number should be NaN
    And the real part of the result should be NaN
    And the imaginary part of the result should be NaN

  Scenario: Adding Complex.NaN to a complex number
    Given a complex number with real part 3.0 and imaginary part 4.0
    And a complex number representing NaN
    When the first complex number is added to the second complex number
    Then the resulting complex number should be NaN
    And the real part of the result should be NaN
    And the imaginary part of the result should be NaN
