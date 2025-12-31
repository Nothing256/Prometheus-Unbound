Feature: Charset Detection from XML Declaration in HTML Parser

  Background:
    Given the default behavior of Jsoup is to use the HTML parser which treats XML declarations as comments

  Scenario: XML declaration should specify charset when parsing as HTML
    Given an input stream containing the following XML content encoded in "ISO-8859-1":
      """
      <?xml version="1.0" encoding="iso-8859-1"?>
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">Hellö Wörld!</html>
      """
    When the content is parsed using Jsoup.parse
    Then the detected charset should be "ISO-8859-1"
    And the document body text should be "Hellö Wörld!"
