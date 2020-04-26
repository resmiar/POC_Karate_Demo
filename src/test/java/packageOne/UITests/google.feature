Feature: web-browser automation
    for help, see: https://github.com/intuit/karate/wiki/ZIP-Release

Background:
  #* configure driver = { type: 'chrome' }
  * configure driver = { timeout: 200000, type: 'chrome' }
  * call read 'locators.json'

@test
Scenario: try to login to github
    and then do a google search

  Given driver 'https://github.com/login'
  And input(transactions.addFirst, 'dummy')
  And input('#password', 'world')
  When submit().click("input[name=commit]")
  Then match html('#js-flash-container') contains 'Incorrect username or password.'
  

  Given driver 'https://google.com'
  And input("input[name=q]", 'karate dsl')
  When submit().click("input[name=btnI]")
  Then waitForUrl('https://github.com/intuit/karate')