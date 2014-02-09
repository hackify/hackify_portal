require 'spec_helper'

feature 'Posting Comments' do
  background do
    @user = User.create(
      :provider => "github",
      :uid => "12345",
      :name => 'Test User',
      :email => 'test@user.com',
      :image => '')

    @event = Event.create(
      :title => 'My Cool Event', 
      :room_name => 'my_cool_event', 
      :body => 'Lorem ipsum dolor sit amet',
      :start => DateTime.now,
      :password => 'abc123',
      :user => @user)
  end

  before do
    # sign in
    visit login_path
    click_link 'github'
  end  

  scenario 'Posting a comment' do
    visit event_path(@event)
    comment = 'This event is just filler text.'

    fill_in 'comment_body', :with => comment

    click_button 'Add comment'

    expect(page).to have_content comment
  end
end