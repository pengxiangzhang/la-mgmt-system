require "test_helper"

class StudentsTest < ApplicationSystemTestCase
  test "Testing Student Deny Admin" do
    visit admin_index_url
    fill_in 'username', with: 'student'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h1", text: "You are not allow to access the page you were looking."
  end

  test "Testing Student Deny LA" do
    visit la_index_url
    fill_in 'username', with: 'student'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h1", text: "You are not allow to access the page you were looking."
  end
end