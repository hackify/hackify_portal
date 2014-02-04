require 'spec_helper'

feature 'Managing events' do
  scenario 'Guests cannot create events' do
    visit events_path
    click_link 'New Event'

    expect(page).to have_content 'Access denied'
  end

  scenario 'Creating a new event' do
    visit events_path

    page.driver.browser.authorize 'admin', 'hack1234'

    click_link 'New Event'

    expect(page).to have_content 'New event'

    fill_in 'Title', :with => 'My Cool Event'
    fill_in 'Room name', :with => 'my_cool_event'
    fill_in 'Body', :with => 'Lorem ipsum dolor sit amet'
    #fill_in 'Start', :with => DateTime.now
    # fill_in 'start_1i', :with => '2015'
    # page.driver.browser.execute_script("$('#event_start_1i').val('2015')")
    
    fill_in 'Password', :with => 'abc123'

    click_button 'Create Event'
    expect(page).to have_content 'My Cool Event'
  end

  context 'with an existing event'  do
    background do
      @event = Event.create(
        :title => 'My Cool Event', 
        :room_name => 'my_cool_event', 
        :body => 'Lorem ipsum dolor sit amet',
        :start => DateTime.now,
        :password => 'abc123')
    end

    scenario 'Editing an existing event' do
      visit event_path(@event)

      page.driver.browser.authorize 'admin', 'hack1234'
      click_link 'Edit'

      fill_in 'Title', :with => 'Another Title'

      click_button 'Update Event'

      expect(page).to have_content 'Another Title'
    end
  end
end