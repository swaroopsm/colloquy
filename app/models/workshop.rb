class Workshop < ActiveRecord::Base
  attr_accessible :content, :presenter, :title, :long, :seats
  belongs_to :conference
  belongs_to :user
  has_many :workshop_attendees
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

  def attendees
  	c = WorkshopAttendee.where(:workshop_id => self)
  	c
  end

end
