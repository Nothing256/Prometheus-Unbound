Feature: Complex Hyperbolic Tangent Stability

  The hyperbolic tangent function (tanh) for complex numbers should handle cases where the real part
  is infinite or sufficiently large to cause overflow in intermediate calculations (like cosh/sinh).
  In these cases, the function should return a finite limit value instead of NaN.

  Scenario: Calculate tanh for complex number with positive infinite real part
    Given a complex number z with real part Infinity and imaginary part 1.0
    When I compute the hyperbolic tangent of z
    Then the result should be the complex number (1.0, 0.0)

  Scenario: Calculate tanh for complex number with negative infinite real part
    Given a complex number z with real part -Infinity and imaginary part 1.0
    When I compute the hyperbolic tangent of z
    Then the result should be the complex number (-1.0, 0.0)

  Scenario: Calculate tanh for complex number with large positive real part
    Given a complex number z with real part 1.0E10 and imaginary part 3.0
    When I compute the hyperbolic tangent of z
    Then the result should be the complex number (1.0, 0.0)

  Scenario: Calculate tanh for complex number with large negative real part
    Given a complex number z with real part -1.0E10 and imaginary part 3.0
    When I compute the hyperbolic tangent of z
    Then the result should be the complex number (-1.0, 0.0)
