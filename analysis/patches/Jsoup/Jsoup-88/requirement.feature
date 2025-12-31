Feature: Boolean Attribute Value Representation

  Ensure that boolean attributes, which are often stored with null values internally,
  are exposed to the user as having empty string values to avoid NullPointerExceptions
  and ensure consistency with the Attributes.get() method.

  Scenario: Retrieving a boolean attribute without a value
    Given a parsed HTML element "<div hidden>"
    When I retrieve the "hidden" Attribute object from the element's attributes
    Then the attribute key should be "hidden"
    And the attribute value should be ""
