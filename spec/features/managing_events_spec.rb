require 'spec_helper'

feature 'Managing events' do

  scenario 'Guests cannot create events' do
    visit events_path
    expect(page).to have_no_content 'New Event'
    visit new_event_path

    current_path.should == login_path
  end

  scenario 'Creating a new event' do
    # sign in
    visit login_path
    click_link 'github'

    visit events_path
    click_link 'New Event'


    expect(page).to have_content 'New event'

    fill_in 'Title', :with => 'My Cool Event'
    fill_in 'Room name', :with => 'my_cool_event'
    fill_in 'Body', :with => 'Lorem ipsum dolor sit amet'
    
    fill_in 'Password', :with => 'abc123'

    click_button 'Create Event'
    expect(page).to have_content 'My Cool Event'
  end

  context 'with an existing event'  do
    background do
      @user = User.create(
        :provider => "github",
        :uid => "123545",
        :name => 'Test User',
        :email => 'user@test.com',
        :image => 'http://test/user.png')

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

    scenario 'Editing an existing event' do
      visit event_path(@event)

      click_link 'Edit'

      fill_in 'Title', :with => 'Another Title'

      click_button 'Update Event'

      expect(page).to have_content 'Another Title'
    end
  end
end