module	WorkshopHelper
	def depict_date(day)
		c = Conference.active.start_date + (day - 1)
		c.strftime("%A, %d %b %Y")
	end
end
