require 'spec_helper'

feature "User browses the available tags" do

  scenario "when opening the home page" do
    Link.create(:url => "www.test.com",
                :title => "Test",
                :tags => [Tag.first_or_create(:text => "test")])
    visit '/'
    expect(page).to have_content("Available tags")
    expect(page).to have_content("test")
  end

end