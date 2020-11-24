require "test_helper"

class AdminsTest < ApplicationSystemTestCase

  test "Testing admin access student" do
    visit student_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Request Appointment"
  end

  test "Testing admin access la" do
    visit la_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Appointment Requests"
  end

  test "regression tests admin change role" do
    visit admin_management_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within("#role_username") do
      fill_in 'username', with: 'joe'
      select 'LA', from: :user_type
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change joe to la."
  end

  test "regression tests admin hiring setting" do
    visit admin_hiring_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within("#open_apply") do
      select 'Off', from: :open_for_apply
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change the open for apply to false."
    click_on "OK"
    within ("#application_email_edit") do
      fill_in 'hiring_email', with: 'hiring_email@example.com'
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change hiring email to hiring_email@example.com."
    click_on "OK"
    within ("#hiring_calendar_edit") do
      fill_in 'hiring_calendar', with: 'https://example.calendar.com'
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change the hiring calendar url."
    click_on "OK"
    within ("#interview_location_edit") do
      fill_in 'interview_location', with: 'example location'
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change the interview location to example location."
  end

  test "regression tests hiring application" do
    visit student_form_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    within("#application_form") do
      fill_in 'NUID', with: '186515'
      fill_in 'Name', with: 'testCI'
      fill_in 'Email', with: 'CI@example.com'
      check 'CSCE155'
      fill_in 'GPA', with: 3
      click_button 'Submit'
    end
    visit admin_hiring_path
    assert_selector "a", text: "CI@example.com"
    within("#change_status_186515") do
      select "scheduling", from: :status
      accept_alert do
        click_on "submit"
      end
    end
    assert_selector "h2", text: "Successfully change status for NUID:186515 to scheduling."
    visit student_application_path
    within("#schedule_interview") do
      fill_in "date", with: "2028-01-01"
      fill_in "time", with: "13:15"
      click_on "submit"
    end
    assert_selector "h2", text: "Successfully schedule the interview time to 1/1/2028 13:15:00."
  end
end