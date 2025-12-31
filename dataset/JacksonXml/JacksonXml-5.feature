Feature: XmlMapper Copy Independence regarding Root Name Lookup

  Background:
    Given a POJO class "Pojo282" annotated with @JacksonXmlRootElement(localName = "AnnotatedName")

  Scenario: Copied XmlMapper respects USE_ANNOTATIONS configuration independently
    Given an XmlMapper "mapper1" is created with default settings
    And "mapper1" is configured to use annotations
    And a copy of "mapper1" named "mapper2" is created
    And "mapper2" is configured to disable USE_ANNOTATIONS
    And "mapper2" is configured to disable FAIL_ON_EMPTY_BEANS
    When "mapper1" serializes an instance of "Pojo282"
    Then the output from "mapper1" should contain "<AnnotatedName>"
    When "mapper2" serializes an instance of "Pojo282"
    Then the output from "mapper2" should contain "<Pojo282>"
    And the output from "mapper2" should NOT contain "<AnnotatedName>"
