require "test_helper"

class AdminsTest < ApplicationSystemTestCase

  test "Testing Admin Change Role" do
    visit admin_management_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within("#role_username") do
      fill_in 'username', with: 'joe'
      select 'LA', from: :user_type
      accept_alert do
        click_on "Submit Request"
        accept_alert # flash message alert
      end
    end
    assert_selector "h5", text: "Role Management"
  end

  test "Testing admin Access student" do
    visit student_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Request Appointment"
  end

  test "Testing admin Access La" do
    visit la_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Appointment Requests"
  end
end
