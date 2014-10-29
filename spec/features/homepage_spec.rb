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
    User.create(:email => "test@test.com",
          :password => 'test',
          :password_confirmation => 'test')
    sign_in("test@test.com", "test")
    expect(page).not_to have_content("Sign in")
    expect(page).not_to have_content("Sign up")
  end

end