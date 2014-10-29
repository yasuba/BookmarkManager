require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature 'viewing the homepage' do

  scenario 'as a signed-out user' do
    visit '/'
    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")
  end

  scenario 'as a signed-in user' do
    visit '/'
    click_link "Sign in"
    fill_in 'email', :with => "test@test.com"
    fill_in 'password', :with => "1234"
    click_button 'Sign in'
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end

end