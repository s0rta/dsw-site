require 'spec_helper'

feature 'Resetting my password' do

  scenario 'User goes through the password reset flow' do
    create(:user, email: 'test@example.com',
                  password: 'password')
    visit '/'
    find('#menu-icon').click
    click_on 'Register / Sign In'
    click_on 'Reset your password'
    fill_in 'E-mail Address', with: 'test@example.com'
    click_on 'Send reset instructions'
    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
    open_last_email
    visit_in_email 'Change my password'
    fill_in 'New Password', with: 'password1'
    fill_in 'Confirm Your New Password', with: 'password1'
    click_on 'Change Password'
    expect(page).to have_content('Your password was changed successfully. You are now signed in.')
  end
end
