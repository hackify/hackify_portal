require 'spec_helper'

feature 'Posting Comments' do
  background do
    @event = Event.create(
      :title => 'My Cool Event', 
      :room_name => 'my_cool_event', 
      :body => 'Lorem ipsum dolor sit amet',
      :start => DateTime.now,
      :password => 'abc123')
  end

  scenario 'Posting a comment' do
    visit event_path(@event)
    comment = 'This event is just filler text.'

    fill_in 'comment_body', :with => comment

    click_button 'Add comment'

    expect(page).to have_content comment
  end
end