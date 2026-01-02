Feature: Search methods should respect Unicode Supplementary Characters

  The search methods in StringUtils (indexOfAny, containsAny, containsNone, indexOfAnyBut) 
  currently treat 'char' values as independent units. This causes incorrect matches when 
  processing Unicode Supplementary Characters (represented as surrogate pairs), as a shared 
  high or low surrogate might trigger a false positive match between two different 
  supplementary characters. The methods should instead treat valid surrogate pairs as 
  atomic Code Points.

  Scenario: indexOfAny distinguishes between different supplementary characters sharing a surrogate
    Given the string containing the supplementary character U+20000 (represented as "\uD840\uDC00")
    When I search for any character in a set containing U+20001 (represented as "\uD840\uDC01")
    Then the result should be -1
    # U+20000 and U+20001 share the high surrogate \uD840, but are distinct code points.

  Scenario: containsAny distinguishes between different supplementary characters
    Given the string containing the supplementary character U+20000
    When I check if it contains any character from a set containing U+20001
    Then the result should be false

  Scenario: containsNone distinguishes between different supplementary characters
    Given the string containing the supplementary character U+20000
    When I check if it contains none of the characters from a set containing U+20001
    Then the result should be true

  Scenario: indexOfAnyBut treats supplementary characters as atomic
    Given the string containing U+20000 followed by U+20001
    When I search for the first index of any character NOT in the set containing U+20000
    Then the result should be 2
    # Index 0 is U+20000 (length 2), so the next character starts at index 2.
    # If U+20000 is in the exclusion set, we skip it completely.
