module ApplicationHelper

	def schedulable_path(conf, s)
		if s.instance_of? Workshop
			conference_workshop_path(conf, s)
		elsif s.instance_of? Plenary
			conference_plenary_path(conf, s)
		else
			conference_period_path(conf, s)
		end
	end

end
