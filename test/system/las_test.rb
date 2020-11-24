require "test_helper"

class LasTest < ApplicationSystemTestCase
  test "Testing LA Deny Admin" do
    visit admin_index_url
    fill_in 'username', with: 'la'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h1", text: "You are not allow to access the page you were looking."
  end

  test "Testing LA Access Student" do
    visit student_index_url
    fill_in 'username', with: 'la'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Request Appointment"
  end
end