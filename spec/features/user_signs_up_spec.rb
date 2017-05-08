require 'rails_helper'

feature 'Registration and sign in' do
  scenario 'User signs up and logs in successfully' do
    visit new_user_path
    fill_in 'Username', with: 'test-user'
    fill_in 'Email Address', with: 'test-user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password'
    click_button 'Register'
    expect(page).to have_content('You have successfully registered')

    fill_in 'Username', with: 'test-user'
    fill_in 'Password', with: 'password'
    click_button 'Log In'
    expect(page).to have_content('Hello test-user')
  end

  scenario 'User signs up unsuccessfully' do
    visit new_user_path
    fill_in 'Username', with: 'test-user'
    fill_in 'Email Address', with: 'test-user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirm Password', with: 'password234'
    click_button 'Register'
    expect(page).to have_content('Please check the following fields')
  end
end
