require 'spec_helper'

feature 'Signing in' do
  #   before do 
  #   # request.env["devise.mapping"] = Devise.mappings[:user] 
  #   request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 
  # end  
  scenario 'Guests can sign in' do
    visit root_path
    click_link 'Sign in'
    current_path.should == login_path
    click_link 'github'
    expect(page).to have_content 'Signed in as Test User'
  end
end