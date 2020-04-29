Feature: Sample for Data-driven tests

Background:
  * configure driver = { timeout: 300000, type: 'chrome' }
  * call read 'locators.json'
  * call read 'testDataUI.json'

@bookAppointmentFixedDate @test
Scenario: Book appointments for hard coded data

  Given call read('healthLogin.feature@validLogin')

  And select(appointmentPage.facilityField, 1)
  And input(appointmentPage.commentField, 'Appointment for Jan First')
  And input(appointmentPage.visitDateField, '01/01/2020')

  When submit().click(appointmentPage.bookAppointmentButton)
  And waitForUrl(healthUrl+'/appointment.php#summary')

  Then match text(confirmationPage.visitDateField) contains '01/01/2020'
  And match text(confirmationPage.facilityField) contains 'Hongkong CURA Healthcare Center'
  And match text(confirmationPage.commentField) contains 'Appointment for Jan First'
  
  And call read('healthLogin.feature@logOut')

  
@bookAppointmentMultipleDates @test
  Scenario Outline:Book appointments for using data driven scenario outline

  Given call read('healthLogin.feature@validLogin')

  And select(appointmentPage.facilityField, <Facility>)
  And input(appointmentPage.commentField, <Comment>)
  And input(appointmentPage.visitDateField, <Date>)

  When submit().click(appointmentPage.bookAppointmentButton)
  And waitForUrl(healthUrl+'/appointment.php#summary')

  Then match text(confirmationPage.visitDateField) contains <Date>
  And match text(confirmationPage.facilityField) contains <FacilityName>
  And match text(confirmationPage.commentField) contains <Comment>

  And call read('healthLogin.feature@logOut')

  Examples:
      | Facility| FacilityName                    |Comment                              |Date        |
      | 0       |'Tokyo CURA Healthcare Center'   |'This is appointment for Jan Second' |'02/01/2020'|
      | 1       |'Hongkong CURA Healthcare Center'|'This is appointment for Jan Third'  |'03/01/2020'|