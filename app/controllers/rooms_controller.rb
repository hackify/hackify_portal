class RoomsController < ApplicationController
  # GET /roomlist
  # GET /roomlist.json
  def index
    @rooms = Room.all
  end

end
