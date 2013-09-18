module SubmissionsHelper
	
	def bursary_status(s)
		s == "1" ? "Yes" : "No"
	end

	def approval_status(s)
		if s == 1
			"Talk"
		elsif s == 2
			"Poster"
		else
			"Rejected"
		end
	end

end
