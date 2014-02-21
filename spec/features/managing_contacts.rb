require 'spec_helper'

feature "Managing contacts" do
  scenario "sending a contact" do
    visit new_contact_path

    expect(page).to have_content 'Tell us what you think!'

    fill_in 'contact_name', :with => 'Joe'
    fill_in 'contact_email', :with => 'joe@blogs.com'
    fill_in 'contact_message', :with => 'This is my message'
    
    click_button 'Submit'
    expect(page).to have_content 'Thanks for the message!'
  end
end