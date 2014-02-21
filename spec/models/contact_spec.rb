require 'spec_helper'

describe Contact do
  describe 'validations' do
    subject(:contact) {Contact.new} #sets up the subject of the describe block
    before { contact.valid? }  #valid is a pre-condition?
    [:name, :email].each do |attribute|
      it "should validate presence of #{attribute}" do
        expect(contact).to have_at_least(1).error_on(attribute)
      end
    end
  end

end