Feature: Byte Order Mark (BOM) Detection in DataUtil

  Background:
    Given the system environment is capable of reading files

  Scenario: Parse HTML file with UTF-16BE encoded content and BOM
    Given a file "src/test/resources/bomtests/bom_utf16be.html" containing UTF-16BE text with a BOM
    When the file is parsed with Jsoup.parse(file, null, "http://example.com")
    Then the document title should contain "UTF-16BE"
    And the document body text should contain "가각갂갃간갅"

  Scenario: Parse HTML file with UTF-16LE encoded content and BOM
    Given a file "src/test/resources/bomtests/bom_utf16le.html" containing UTF-16LE text with a BOM
    When the file is parsed with Jsoup.parse(file, null, "http://example.com")
    Then the document title should contain "UTF-16LE"
    And the document body text should contain "가각갂갃간갅"

  Scenario: Parse HTML file with UTF-32BE encoded content and BOM
    Given a file "src/test/resources/bomtests/bom_utf32be.html" containing UTF-32BE text with a BOM
    When the file is parsed with Jsoup.parse(file, null, "http://example.com")
    Then the document title should contain "UTF-32BE"
    And the document body text should contain "가각갂갃간갅"

  Scenario: Parse HTML file with UTF-32LE encoded content and BOM
    Given a file "src/test/resources/bomtests/bom_utf32le.html" containing UTF-32LE text with a BOM
    When the file is parsed with Jsoup.parse(file, null, "http://example.com")
    Then the document title should contain "UTF-32LE"
    And the document body text should contain "가각갂갃간갅"
