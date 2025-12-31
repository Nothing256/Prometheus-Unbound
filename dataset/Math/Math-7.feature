Feature: ODE Integration Event Scheduling

  Scenario: Non-triggering events must be fast-forwarded when a step is interrupted
    Given a system of First Order Differential Equations
    And two event handlers are registered: "HandlerA" and "HandlerB"
    And "HandlerA" is scheduled to trigger at T_A
    And "HandlerB" is scheduled to trigger at T_B
    And T_A < T_B
    And the integration starts at T_Start < T_A
    And "HandlerA" requests a RESET_STATE when triggered
    And "HandlerB" enforces that it is only checked for times t >= T_Last_Step_End
    When the integrator integrates from T_Start past T_B
    Then the integration should complete successfully
    And "HandlerB" should not receive checks for times t < T_A during the step immediately following T_A
