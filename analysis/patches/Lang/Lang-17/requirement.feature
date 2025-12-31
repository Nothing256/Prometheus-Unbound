Feature: CharSequenceTranslator Iteration Logic

  Scenario: Correctly handle surrogate pairs during translation
    Given a CharSequenceTranslator instance (e.g. StringEscapeUtils.ESCAPE_XML)
    When translating a CharSequence containing a surrogate pair (e.g. "\uD842\uDFB7") followed by a regular character (e.g. "A")
    Then the translator must correctly advance the index past the surrogate pair (consuming 2 chars)
    And the subsequent character "A" must be correctly processed and included in the output
    And the output should match the input "\uD842\uDFB7A" if no escaping is applied to these characters
