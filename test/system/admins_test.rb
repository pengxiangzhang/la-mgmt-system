require 'test_helper'

class AdminsTest < ApplicationSystemTestCase

  test 'Testing admin access student' do
    visit student_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h5', text: 'Request Appointment'
  end

  test 'Testing admin access la' do
    visit la_index_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    assert_selector 'h5', text: 'Appointment Requests'
  end

  test 'regression tests admin system setting' do
    visit admin_management_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within('#system_url_edit') do
      fill_in 'system_url', with: 'https://testurl.unl.edu'
      accept_alert do
        click_on 'Submit Request'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully change system url to https://testurl.unl.edu.'
    click_on 'OK'
    within('#role_form_joe') do
      select 'LA', from: :user_type
      accept_alert do
        click_on 'Submit Request'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully changed joe to la.'
    click_on 'OK'
    within ('#admin_email_edit') do
      fill_in 'email', with: 'hiring_email@example.com'
      accept_alert do
        click_on 'Submit Request'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully change admin email to hiring_email@example.com.'
    click_on 'OK'
  end

  test 'regression tests admin hiring setting' do
    visit admin_hiring_path
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'

    within('#open_apply') do
      select 'Off', from: :open_for_apply
      accept_alert do
        click_on 'Submit Request'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully change the open for apply to false.'
    click_on 'OK'
    within ('#hiring_calendar_edit') do
      fill_in 'hiring_calendar', with: 'https://example.calendar.com'
      accept_alert do
        click_on 'Submit Request'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully change the hiring calendar url.'
    click_on 'OK'
    within ('#interview_location_edit') do
      fill_in 'interview_location', with: 'example location'
      accept_alert do
        click_on 'Submit Request'
      end
    end
    assert_selector 'h2', text: 'Successfully change the interview location to example location.'
  end

  test 'regression tests hiring application' do
    visit admin_hiring_url
    fill_in 'username', with: 'admin'
    fill_in 'password', with: 'any password'
    click_button 'Login'
    within('#delete_all') do
      accept_alert do
        click_on 'Delete All Application'
      end
    end
    sleep 1
    assert_selector 'h2', text: 'Successfully delete all applications.'
    click_on 'OK'
  end
end