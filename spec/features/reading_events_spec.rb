require 'spec_helper'

feature 'Reading the Events' do
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
      :user => @user)
    Event.create(
      :title => 'Another Cool Event', 
      :room_name => 'another_cool_event', 
      :body => 'Lorem ipsum dolor sit amet',
      :start => DateTime.now,
      :user => @user)

  end

  scenario 'Reading the events index' do
    visit events_path

    expect(page).to have_content 'My Cool Event'
    expect(page).to have_content 'Another Cool Event'
  end

  scenario 'Reading an individual event' do
    visit events_path
    click_link 'My Cool Event'
    expect(current_path).to eq event_path(@event)
  end

end
