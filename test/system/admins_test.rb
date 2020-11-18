require "test_helper"

class AdminsTest < ApplicationSystemTestCase
  # test "Testing change roles" do
  #   visit "admin/management"
  #   fill_in 'username', with: 'johndoe'
  #   fill_in 'password', with: 'any password'
  #   click_button 'Login'
  #
  #   #click_on "User Management"
  #   within("#role_username") do
  #     fill_in 'username', with: 'johndoe'
  #     select 'LA', from: :user_type
  #     accept_alert do
  #       click_on "Submit Request"
  #     end
  #   end
  #   assert_selector "h5", text: "Role Management"
  # end

  test "Testing admin Access student" do
    visit "student/index"
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Request Appointment"
  end

  test "Testing admin Access La" do
    visit "la/index"
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector "h5", text: "Appointment Requests"
  end
end
