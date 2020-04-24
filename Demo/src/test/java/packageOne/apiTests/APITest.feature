@apiTests
Feature: To verify basic features of the application are working

  Background:
    Given url apiURL
    * configure headers = { Authorization: '#(apiKey)' }
    * def testData = read("testData.json")
    # * configure followRedirects = false

  @addanddelete
  Scenario Outline:Verify add and Delete user functionalities are working
    # * call read('add-user.feature') {'user':'#(testData.testUser1)'}
    Given path 'users'
    When request testData.<user>
    And method post
    Then status 200
    * match response['_meta'] contains testData.addUsersuccessMsg
    # And match response['_meta'] contains {'code':201} //not getting 201 status because of automatict redirect after post request
    * def userid = response['result']['id']
    And match response['result'] contains testData.<user>
    * call read('delete-user.feature') {'User_ID':'#(userid)'}
    Examples:
      | user   |
      | testUser  |
      | UserWithAllDetails  |
    
  @updateuser
  Scenario: Update existing user details
    Given path 'users'
    When request testData.testUser
    And method post
    Then status 200
    * match response['_meta'] contains testData.addUsersuccessMsg
    # And match response['_meta'] contains {'code':201}
    * def userid = response['result']['id']
    And match response['result'] contains testData.testUser
    Given path 'users',userid
    Then request testData.UserWithAllDetails
    When method put
    Then status 200
    And match response['result'] contains testData.UserWithAllDetails
    * call read('delete-user.feature') {'User_ID':'#(userid)'}
  
  @updateInvalidUserData
  Scenario Outline: Verify user data cannot be updated with invalid data
    Given path 'users'
    When request testData.testUser
    And method post
    Then status 200
    * match response['_meta'] contains testData.addUsersuccessMsg
    * def userid = response['result']['id']
    And match response['result'] contains testData.testUser
    Given path 'users',userid
    Then request testData.<user>
    When method put
    Then status 200
    * match response['_meta'] contains testData.validationFailMsg
    And match response['_meta'] contains {'code':422}
    * call read('delete-user.feature') {'User_ID':'#(userid)'}
    Examples:
      | user   |
      | UserWithInvalidGender  |
      | UserWithInvalidEmail    |
      | UserWithInvalidWebsite |
      | UserWithInvalidStatus |

  @userdataValidation
  Scenario Outline: Verify invalid user data cannot be added
    Given path 'users'
    When request <user>
    And method post
    Then status 200
    * match response['_meta'] contains testData.validationFailMsg
    And match response['_meta'] contains {'code':422}
    Examples:
      | testData.invalidUsers   |