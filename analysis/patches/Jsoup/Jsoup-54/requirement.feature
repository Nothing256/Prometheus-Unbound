Feature: Robust W3C DOM Conversion

  Background:
    Given a Jsoup document containing HTML elements

  Scenario: Convert HTML with invalid attribute names
    Given an HTML document with an element having attributes:
      | attribute | description               |
      | "         | quote only                |
      | name"     | alphanumeric with quote   |
      | 123       | starts with digit         |
    When the document is converted to a W3C DOM
    Then the conversion should complete without error
    And the resulting W3C element should validly retain attributes that can be sanitized
    And attributes that result in invalid XML names after sanitization should be discarded
