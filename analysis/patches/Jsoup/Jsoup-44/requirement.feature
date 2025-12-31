Feature: Correctly handle invalid content in nested tables

  Scenario: Foster parenting preserves order relative to preceding comments in nested tables
    Given the input HTML:
      """
      <table>
        <tr>
          <td>
            <table>
              <tr>
                <!--Comment-->
                <table>
                  <p>Why am I here?</p>
                </table>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      """
    When the HTML is parsed
    Then the text "Why am I here?" should appear after the comment "Comment" in the rendered output
    And the structure should reflect that the paragraph is fostered out of the inner table but remains after the preceding table content
