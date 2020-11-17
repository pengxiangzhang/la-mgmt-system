require "test_helper"

class AdminsTest < ApplicationSystemTestCase

  test "Testing change roles" do
    visit "admin/management"
    fill_in 'username', with: 'johndoe'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    #click_on "User Management"
    within("#role_username") do
      fill_in 'username', with: 'johndoe'
      select 'LA', from: :user_type
      accept_alert do
        click_on "Submit Request"
      end
    end
    assert_selector "h5", text: "Role Management"
  end
end
