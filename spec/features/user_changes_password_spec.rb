require 'rails_helper'

feature 'User changes password' do

  scenario 'User successfully changes password' do
    lily = Fabricate(:user)
    sign_in(lily)
    click_link "Hello #{lily.username}"
    fill_in 'Old Password', with: lily.password
    fill_in 'New Password', with: 'new_password'
    fill_in 'New Password Confirmation', with: 'new_password'
    click_button 'Change Password'
    expect(page).to have_content('You have successfully changed your password')

    click_link 'Sign Out'
    click_link 'Sign In'
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: 'new_password'
    click_button 'Log In'
    expect(page).to have_content("Hello #{lily.username}")
  end

  scenario 'User unsuccessfully changes password with an invalid old password' do
    lily = Fabricate(:user)
    sign_in(lily)
    click_link "Hello #{lily.username}"
    fill_in 'Old Password', with: 'not_a_valid_password'
    fill_in 'New Password', with: 'new_password'
    fill_in 'New Password Confirmation', with: 'new_password'
    click_button 'Change Password'
    expect(page).to have_content('Please check the following errors')

    click_link 'Sign Out'
    click_link 'Sign In'
    fill_in 'Username', with: lily.username
    fill_in 'Password', with: lily.password
    click_button 'Log In'
    expect(page).to have_content("Hello #{lily.username}")
  end
end
