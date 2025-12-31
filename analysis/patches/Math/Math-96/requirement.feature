Feature: Complex Number Equality for Signed Zeros

  To ensure intuitive arithmetic comparisons, the Complex class must treat
  positive zero (0.0) and negative zero (-0.0) as equal in both real and
  imaginary parts. This applies to both equals() and hashCode().

  Scenario: Multiplication yielding negative zero real part
    Given z1 is (0.0, 1.0)
    And z2 is (-1.0, 0.0)
    When I multiply z1 and z2
    Then the result should equal (0.0, -1.0)

  Scenario: Equality and HashCode ignore sign of zero
    Given a complex number A with values (0.0, 0.0)
    And a complex number B with values (-0.0, -0.0)
    Then A should be equal to B
    And the hash code of A should be equal to the hash code of B
