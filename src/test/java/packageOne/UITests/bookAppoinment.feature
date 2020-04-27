Feature: Sample for Data-driven tests

Background:
  * configure driver = { timeout: 300000, type: 'chrome' }
  * call read 'locators.json'
  * call read 'testDataUI.json'

@bookAppointmentForJan, @test
Scenario: Book appointments for hard coded data

  Given call read('healthLogin.feature')

  And select(appointmentPage.facilityField, 1)
  And input(appointmentPage.commentField, 'Appointment for Jan First')
  And input(appointmentPage.visitDateField, '01/01/2020')

  When submit().click(appointmentPage.bookAppointmentButton)
  And waitForUrl(healthUrl+'/appointment.php#summary')

  Then waitForText(confirmationPage.visitDateField, '01/01/2020')

  
@bookAppointmentMultipleDates, @test1
  Scenario Outline:Book appointments for using data driven scenario outline

  Given call read('healthLogin.feature')

  And select(appointmentPage.facilityField, <Facility>)
  And input(appointmentPage.commentField, <Comment>)
  And input(appointmentPage.visitDateField, <Date>)

  When submit().click(appointmentPage.bookAppointmentButton)
  And waitForUrl(healthUrl+'/appointment.php#summary')

  Then waitForText(confirmationPage.visitDateField, <Date>)
  And waitForText(confirmationPage.facilityField, <FacilityName>)
  Examples:
      | Facility| FacilityName                    |Comment                             |Date        |
      | 1       |'Tokyo CURA Healthcare Center'   |'This is appointmnt for Jan Second' |'02/01/2020'|
      | 2       |'Hongkong CURA Healthcare Center'|'This is appointmnt for Jan Third'  |'03/01/2020'|