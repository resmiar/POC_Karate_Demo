@ignore
Feature: To delete a user

Scenario:
    Given url apiURL
    * call read("classpath:packageOne/EncryptDecrypt.js")
    * def apiToken = call decrypt  apiKey
    * configure headers = { Authorization: '#(apiToken)' }
    Given path 'users',User_ID
    When method Delete
    Then status 200
    And match response['_meta'] contains {'code':204}