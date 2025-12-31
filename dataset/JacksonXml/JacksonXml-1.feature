Feature: Handle empty XML elements as empty Objects in unwrapped lists

  Scenario: Deserialize an unwrapped list containing an empty element with empty text
    Given a class "Records" with an unwrapped list field "records" of type "Record"
    And the XML input is:
      """
      <Records>
        <records></records>
        <records>
          <fields name='b'/>
        </records>
      </Records>
      """
    When the XML is deserialized into "Records"
    Then the list "records" should have size 2
    And the first element of "records" should not be null
    And the second element of "records" should not be null
