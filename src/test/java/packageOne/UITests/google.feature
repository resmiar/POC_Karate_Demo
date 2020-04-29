Feature: web-browser automation
    for help, see: https://github.com/intuit/karate/wiki/ZIP-Release

Background: 
  Given configure driver = { timeout: 500000, type: browserName }
  * call read 'locators.json'

@invalidLogin @test 
Scenario: Validate error message for gitHub invalid login

  Given driver UrlBase+'login'
  And input(gitHubLogin.userName, 'dummy')
  And input(gitHubLogin.password, 'world')
  When submit().click(gitHubLogin.submitButton)
  Then match html(gitHubLogin.errorMessageContainer) contains 'Incorrect username or password.'
  
@googleSearch @test 
Scenario: Validate google search returns gitHub page
  Given driver SecondaryUrl

  And input(googlePage.searchField, 'karate dsl')
  When submit().click(googlePage.searchResult)
  Then waitForUrl(googlePage.resultUrl)
  And match driver.url contains googlePage.resultUrl