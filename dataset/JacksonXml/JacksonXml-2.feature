Feature: Mixed Content Support in XML Parsing

  Scenario: Text content followed by a child element should be preserved
    Given an XML input "<windSpeed units='kt'> 27 <radius>20</radius></windSpeed>"
    And a target class "WindSpeed" with:
      | Field  | Type   | Annotation       |
      | value  | int    | @JacksonXmlText  |
      | radius | Radius |                  |
    And the "Radius" class has a field "value"
    When the XML is deserialized into the "WindSpeed" object
    Then the field "value" should be equal to 27
    And the field "radius" should not be null
    And the nested field "radius.value" should be equal to 20
