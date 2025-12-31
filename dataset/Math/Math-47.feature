Feature: Complex Number Arithmetic and Functions

  Scenario: Division by Zero returns Infinity
    Given a complex number with real part 3.0 and imaginary part 4.0
    When I divide this complex number by Complex.ZERO
    Then the result should be Complex.INF

  Scenario: Inverse Tangent of Imaginary Unit returns Infinity
    Given the complex number I (0.0 + 1.0i)
    When I compute the inverse tangent (atan) of I
    Then the result should be infinite
