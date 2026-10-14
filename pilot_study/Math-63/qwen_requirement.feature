Feature: Array comparison with NaN values
  As a user of MathUtils
  I want array comparison methods to handle NaN values according to IEEE 754 standard
  So that arrays containing NaN values are compared properly based on the specific method semantics

  Scenario: Array equality comparison excluding NaN values
    Given two double arrays containing NaN values at the same positions
    When I call MathUtils.equals(array1, array2)
    Then it should return false
    And specifically comparing [NaN] with [NaN] should return false
    And comparing arrays with identical values except NaN should return false

  Scenario: Array equality comparison including NaN values
    Given two double arrays containing NaN values at the same positions
    When I call MathUtils.equalsIncludingNaN(array1, array2)
    Then it should return true
    And specifically comparing [NaN] with [NaN] should return true
    And comparing arrays with identical values including NaN should return true

  Scenario: Array equality comparison with regular values
    Given two double arrays containing identical regular values
    When I call MathUtils.equals(array1, array2)
    Then it should return true

  Scenario: Array equality comparison with different values
    Given two different double arrays that don't differ by NaN values
    When I call MathUtils.equals(array1, array2)
    Then it should return false

  Scenario: Array equality comparison with null arrays
    Given either one or both arrays are null
    When I call MathUtils.equals(array1, array2)
    Then it should return true only if both arrays are null
    And comparing null with non-null arrays should return false

  Scenario: Array equality comparison with different dimensions
    Given two double arrays with different lengths
    When I call MathUtils.equals(array1, array2)
    Then it should return false