Feature: Sample for Data-driven tests

Background:
  * configure driver = { timeout: 300000, type: 'chrome' }
  * call read 'locators.json'

@test
Scenario: try to login to github
    and then do a google search

  Given driver 'https://google.com'

  And input("input[name=q]", 'karate dsl')
  When submit().click("input[name=btnI]")
  Then waitForUrl('https://github.com/intuit/karate')