class WorkshopAttendee < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :workshop

	validate :seats_full
	validate :duplicate_attend

	def can_attend?
		flag = true
		self.user.workshop_attendees.each do |w|
			if w.workshop.schedule.day == self.workshop.schedule.day
				flag = false
				break
			end
		end
		flag
	end

	private
	def seats_full
		errors.add(:base, "Seats for this workhsop are full") if self.workshop.seats == WorkshopAttendee.where(:workshop_id => self.workshop).count
	end

	def duplicate_attend
		errors.add(:base, "You can only attend a single workhsop for a day.") unless self.can_attend?
	end

end
