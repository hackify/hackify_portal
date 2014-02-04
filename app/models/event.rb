class Event < ActiveRecord::Base
  has_many :comments
  
  validates_presence_of :title, :room_name, :body, :start, :password
  validates :room_name, :allow_blank => false, :format => { :with => /\A[-\w.]+\z/, :message => "No spaces allowed in room name" }
end