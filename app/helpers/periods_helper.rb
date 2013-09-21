module PeriodsHelper

	def period_categories
		{ "Normal Session" => Period::NORMAL_SESSION, "Special Session" => Period::SPECIAL_SESSION, "Break" => Period::BREAK_SESSION }
	end

end
