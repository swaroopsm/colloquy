class WorkshopAttendee < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :users
  belongs_to :workshop

  
end
