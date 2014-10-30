require 'spec_helper'

feature "User browses the available tags" do

  before(:each) do
    Link.create(:url => "www.test.com",
                :title => "Test",
                :tags => [Tag.first_or_create(:text => "test")])
  end

  scenario "when opening the home page" do
    visit '/'
    expect(page).to have_content("Available tags")
    expect(page).to have_content("test")
  end

  scenario "clicking on a tag" do
    visit '/'
    click_link("test")
    expect(current_path).to eq('/tags/test')
  end
end