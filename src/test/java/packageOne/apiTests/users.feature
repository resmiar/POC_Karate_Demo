@ignore
Feature: sample karate test script

@test123
  Scenario: get all users and then get the first user by id
    Given url 'https://jsonplaceholder.typicode.com/users'
    When method get
    Then status 200
    Then print response
    * def myVar = response
    Then print 'myVar is'+myVar