Feature: Login feature for healthcare demo app

Background: 
  Given configure driver = { timeout: 500000, type: browserName }
  * call read 'locators.json'
  * call read 'testDataUI.json'

@validLogin, @test 
Scenario: Login to healthcare app

  Given driver healthUrl
  And submit().click(healthLogin.makeAppointmentButton)
  And waitForUrl(healthUrl+'/profile.php#login')

  And input(healthLogin.userName, healthLoginData.userName)
  And input(healthLogin.password, healthLoginData.password)
  When submit().click(healthLogin.submitButton)
  
  And waitForUrl(healthUrl+'/#appointment')
  Then assert locate(appointmentPage.bookAppointmentButton).exists