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

  test "regression tests admin system setting" do
    visit admin_management_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within("#system_url_edit") do
      fill_in 'system_url', with: "https://testurl.unl.edu"
      accept_alert do
        click_on "Submit Request"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change system url to https://testurl.unl.edu."
    click_on "OK"
    within("#role_username") do
      fill_in 'username', with: 'joe'
      select 'LA', from: :user_type
      accept_alert do
        click_on "Submit Request"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change joe to la."
    click_on "OK"
    within("#role_form_joe") do
      select 'Student', from: :user_type
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h2", text: "Successfully change joe to student."
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
    sleep 1
    assert_selector "h2", text: "Successfully change the open for apply to false."
    click_on "OK"
    within ("#application_email_edit") do
      fill_in 'hiring_email', with: 'hiring_email@example.com'
      accept_alert do
        click_on "Submit Request"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change hiring email to hiring_email@example.com."
    click_on "OK"
    within ("#hiring_calendar_edit") do
      fill_in 'hiring_calendar', with: 'https://example.calendar.com'
      accept_alert do
        click_on "Submit Request"
      end
    end
    sleep 1
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
    sleep 1
    assert_selector "h2", text: "Successfully change status for NUID:186515 to scheduling."
    visit student_application_path
    within("#schedule_interview") do
      fill_in "date", with: "2028-01-01"
      fill_in "time", with: "13:15"
      click_on "submit"
    end
    sleep 1
    assert_selector "h2", text: "Successfully schedule the interview time to 1/1/2028 13:15:00."
    click_on "OK"
    visit admin_hiring_path
    within("#change_status_186515") do
      select "offered", from: :status
      accept_alert do
        click_on "submit"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change status for NUID:186515 to offered."
    click_on "OK"
    visit student_application_path
    within("#accept_offer_edit") do
      click_on "Accept Offer"
    end
    sleep 1
    assert_selector "h2", text: "Successfully to accept the job offer."
    click_on "OK"
    visit admin_hiring_path
    within("#application_note") do
      fill_in "NUID", with: "186515"
      fill_in "score", with: 5
      accept_alert do
        click_on "Submit Request"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change note for NUID:186515."
    click_on "OK"
    within("#change_status_186515") do
      select "reject", from: :status
      accept_alert do
        click_on "submit"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change status for NUID:186515 to reject."
    click_on "OK"
    within("#change_status_186515") do
      select "reject", from: :status
      accept_alert do
        click_on "submit"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change status for NUID:186515 to reject."
    click_on "OK"
    within("#change_status_186515") do
      select "delete", from: :status
      accept_alert do
        click_on "submit"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully change status for NUID:186515 to delete."
    click_on "OK"
    within("#delete_all") do
      accept_alert do
        click_on "Delete All Application"
      end
    end
    sleep 1
    assert_selector "h2", text: "Successfully delete all applications."
    click_on "OK"
  end
end