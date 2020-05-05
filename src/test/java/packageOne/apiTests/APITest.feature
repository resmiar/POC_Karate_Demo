@apiTests
Feature: To verify basic features of the application are working

  Background:
    Given url apiURL
    * def testData = read("testData.json")
    * call read("classpath:packageOne/EncryptDecrypt.js")
    # * configure followRedirects = false
    * def apiToken = call decrypt  apiKey // for encryption use "* def encrypted = call encrypt  text"
    * configure headers = { Authorization: '#(apiToken)' }

  @addanddelete @test
  Scenario Outline:Verify add and Delete user functionalities are working
    # * call read('add-user.feature') {'user':'#(testData.testUser1)'}
    Given path 'users'
    When request testData.<user>
    And method post
    Then status 200
    * match response._meta contains testData.addUsersuccessMsg
    * print response.result
    # And match response['_meta'] contains {'code':201} //not getting 201 status because of automatict redirect after post request
    * def userid = response['result']['id']
    And match response['result'] contains testData.<user>
    * call read('delete-user.feature') {'User_ID':'#(userid)'}
    Examples:
      | user   |
      | testUser  |
      | UserWithAllDetails  |
    
  @updateuser @test
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
  
  @updateInvalidUserData @test
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

  @userdataValidation @test
  Scenario Outline: Verify invalid user data cannot be added
    Given path 'users'
    When request <user>
    And method post
    Then status 200
    * match response['_meta'] contains testData.validationFailMsg
    And match response['_meta'] contains {'code':422}
    Examples:
      | testData.invalidUsers   |

  @parsejson
  Scenario: json parsing demo
    Given path 'users'
    When method get
    Then status 200
    * print response._meta
    * def result = $response.result[*].email
    * print response
    * print result
    Then match each result == '#regex .*@.*\..*'
    * def users = $response.result
    * print users
    Then match each users contains {first_name:'#string', gender:'#regex ^male|female$' ,dob:'#regex \\d{4}-\\d{2}-\\d{2}',website:'#ignore'} //#value - is a marker

  @failretrydemo
  Scenario: Fail retry demo
    * configure retry = { count: 5, interval: 1000 }
    Given path 'users',0
    And retry until response._meta.code == 200
    When method get