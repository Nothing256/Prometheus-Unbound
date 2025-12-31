Feature: Form Data Integrity
  Ensure that FormElement only submits data from valid, current form controls.

  Scenario: Form data excludes removed form controls
    Given a form element exists in the document
    And the form has a child input element with name "pass"
    When the "pass" input element is removed from the DOM
    Then the form data retrieved from the form should not contain the key "pass"
