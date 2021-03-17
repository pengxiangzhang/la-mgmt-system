require 'test_helper'

class StudentsTest < ApplicationSystemTestCase
  test 'Testing Student Deny Admin' do
    visit admin_index_url
    fill_in 'username', with: 'student'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h1', text: '403'
  end

  test 'Testing Student Deny LA' do
    visit la_index_url
    fill_in 'username', with: 'student'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h1', text: '403'
  end

  test 'regression tests submit application' do
    visit student_form_url
    fill_in 'username', with: 'student'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    within('#application_form') do
      fill_in 'NUID', with: '186515'
      fill_in 'Name', with: 'testCI'
      fill_in 'Email', with: 'CI@example.com'
      check 'CSCE155'
      fill_in 'GPA', with: 3
      click_button 'Submit'
    end
    assert_selector 'h5', text: 'Application Status'
    within('#withdraw_application') do
      click_button 'Withdraw Application'
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully withdraw the application.'
    click_on 'OK'
  end
end