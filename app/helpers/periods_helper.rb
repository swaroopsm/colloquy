module PeriodsHelper

	def period_categories
		{ "Normal Session" => Period::NORMAL_SESSION, "Special Session" => Period::SPECIAL_SESSION, "Break" => Period::BREAK_SESSION }
	end

	def period_category(cat)
		if cat == Period::NORMAL_SESSION
			"Normal Session"
		elsif cat == Period::SPECIAL_SESSION
			"Special Session"
		elsif cat == Period::BREAK_SESSION
			"Break"
		else
			"Normal Session"
		end
	end

end
