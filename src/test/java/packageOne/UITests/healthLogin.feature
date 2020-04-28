Feature: Login feature for healthcare demo app

Background: 
  Given configure driver = { timeout: 500000, type: browserName }
  * configure retry = { count: 5, interval: 5000 }
  * call read 'locators.json'
  * call read 'testDataUI.json'

@validLogin @ignore 
Scenario: Login to healthcare app

  Given driver healthUrl
  And waitFor(healthLogin.makeAppointmentButton).click()
  And waitForUrl(healthUrl+'/profile.php#login')

  And input(healthLogin.userName, healthLoginData.userName)
  And input(healthLogin.password, healthLoginData.password)
  When submit().click(healthLogin.submitButton)
  
  And waitForUrl(healthUrl+'/#appointment')
  Then assert locate(appointmentPage.bookAppointmentButton).exists

  @logOut @ignore
Scenario: Logout
 
  Given waitFor(confirmationPage.sideMenuButton).click()
  When click(confirmationPage.logout)
  Then assert waitFor(healthLogin.makeAppointmentButton).exists