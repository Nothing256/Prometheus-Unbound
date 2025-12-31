Feature: Correct XPath Generation for Aliased Namespaces
  To ensure unique and correct identification of XML nodes
  As a developer using JXPath
  I want the XPath generation logic to correctly index sibling nodes that share the same Namespace URI and Local Name, regardless of their prefixes.

  Scenario: Generating XPath for a node with a preceding sibling having a different prefix but same Namespace URI
    Given an XML document containing:
      """
      <a:doc xmlns:a="ns">
        <a:elem />
        <b:elem xmlns:b="ns" />
      </a:doc>
      """
    And I have registered the prefix "a" for the namespace URI "ns"
    When I retrieve the XPath for the second child element "b:elem"
    Then the generated XPath should be "/a:doc[1]/a:elem[2]"
    And the position index should be calculated based on the local name and namespace URI, not the literal node name (prefix:local).
