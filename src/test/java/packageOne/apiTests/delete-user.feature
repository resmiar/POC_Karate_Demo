@ignore
Feature: To delete a user

Scenario:
    Given url apiURL
    * configure headers = { Authorization: '#(apiKey)' }
    Given path 'users',User_ID
    When method Delete
    Then status 200
    And match response['_meta'] contains {'code':204}