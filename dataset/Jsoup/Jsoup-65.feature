Feature: HTML Template Tag Support in Tables

  Scenario: Parsing template tags inside table structures
    Given the HTML input:
      """
      <table>
        <thead>
          <template>
            <th>Header</th>
          </template>
        </thead>
        <tbody>
          <template>
            <tr><td>Cell</td></tr>
          </template>
        </tbody>
      </table>
      """
    When the document is parsed
    Then the "thead" element should have a child "template"
    And the "template" element inside "thead" should have a child "th"
    And the "tbody" element should have a child "template"
    And the "template" element inside "tbody" should have a child "tr"
    And the "template" elements should remain inside the table structure
