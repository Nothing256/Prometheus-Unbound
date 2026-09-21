Feature: Complex Number Addition with NaN Values

  Scenario: Adding Complex.NaN to a complex number
    Given a complex number with real part 3.0 and imaginary part 4.0
    When added with Complex.NaN
    Then the result should be NaN

  Scenario: Adding a complex number with a NaN imaginary part
    Given a complex number with real part 3.0 and imaginary part 4.0
    And a complex number with real part 1.0 and imaginary part NaN
    When the two complex numbers are added
    Then the real part of the result should be NaN
    And the imaginary part of the result should be NaN
    And the result should be NaN
