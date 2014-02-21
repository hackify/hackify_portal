class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    if current_user
      @contact.name = current_user.name
      @contact.email = current_user.email
    end
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your message!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end
