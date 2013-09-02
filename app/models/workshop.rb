class Workshop < ActiveRecord::Base
  attr_accessible :content, :presenter, :title, :long, :seats
  belongs_to :conference
  belongs_to :user
  has_many :workshop_attendees
  has_one :schedule, :foreign_key => :schedulable_id
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

  def attendees
  	c = WorkshopAttendee.where(:workshop_id => self)
  	c
  end

  def self.has_registered_for_day(user, dayy)
    can_register = true
    workshops_registered = WorkshopAttendee.where(:user_id => user).includes({:workshop => :schedule})
    workshops_registered.each do |w|
      unless w.workshop.schedule.nil?
        if w.workshop.schedule.day == dayy
          can_register = false
          return can_register
        end
      end
    end
    return can_register
  end

	def seats_left
		self.seats - self.workshop_attendees.size
	end

end
