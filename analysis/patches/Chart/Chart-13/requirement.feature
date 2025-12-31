Feature: BorderArrangement Sizing with Width Constraint

  Scenario: Arrange blocks where the left block is wider than the container's width constraint
    Given a BlockContainer with a BorderArrangement
    And a block with width 12.3 and height 45.6 added to the LEFT edge
    And a block with width 5.4 and height 3.2 added to the RIGHT edge
    And a center block with width 10.0 and height 20.0
    When the container is arranged with a fixed width constraint of 10.0
    Then the arrangement should complete without error
    And the resulting width should be 10.0
