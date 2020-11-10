require "application_system_test_case"

class AdminsTest < ApplicationSystemTestCase
   test "Testing change roles" do
    visit "admin/management"
    sign_in users(:one)

    #click_on "User Management"
    fill_in "username" , with: "ngerstbrein"
    select 'LA' , from: :user_type
    click_on "Submit Request"
    assert_selector "h5", text: "Role Management"
   end
end
