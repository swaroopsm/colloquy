class WorkshopAttendee < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :workshop

	validate :seats_full

	private
	def seats_full
		errors.add(:base, "Seats for this workhsop are full") if self.workshop.seats == WorkshopAttendee.where(:workshop_id => self.workshop).count
	end

end
