require 'test_helper'

class LasTest < ApplicationSystemTestCase
  test 'Testing la deny admin' do
    visit admin_index_url
    fill_in 'username', with: 'la'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h1', text: '403'
  end

  test 'Testing la access student' do
    visit student_index_url
    fill_in 'username', with: 'la'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h5', text: 'Request Appointment'
  end
end