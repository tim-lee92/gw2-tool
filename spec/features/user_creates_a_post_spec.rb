require 'rails_helper'

describe 'Creating threads' do
  scenario 'User successfully creates a thread' do
    sign_in
    click_link 'Discuss'
    click_link 'New Thread'
    fill_in 'Title', with: 'A feature spec for thread creation'
    fill_in 'Content', with: 'Some description'
    click_button 'Create thread'
    expect(page).to have_content('A feature spec for thread creation')
  end

  scenario 'User unsuccessfully creates a thread' do
    sign_in
    click_link 'Discuss'
    click_link 'New Thread'
    fill_in 'Title', with: 'A feature spec for thread creation'
    click_button 'Create thread'
    expect(page).to have_content('Create a thread:')
  end
end
