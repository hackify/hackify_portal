require 'spec_helper'

describe Event do
  describe 'validations' do
    subject(:event) {Event.new} #sets up the subject of the describe block
    before { event.valid? }  #valid is a pre-condition?
    [:title, :body, :room_name, :start].each do |attribute|
      it "should validate presence of #{attribute}" do
        expect(event).to have_at_least(1).error_on(attribute)
        expect(event.errors.messages[attribute]).to include "can't be blank"
      end
    end

    #special one
    it "should validate empty spaces for room_name" do
      event2 = Event.new(:room_name => 'it has spaces')
      event2.valid?
      expect(event2.errors.messages[:room_name]).to include "No spaces allowed in room name"
    end
  end

end