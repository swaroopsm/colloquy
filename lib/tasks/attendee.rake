namespace :attendee do

	desc "Resets Passwords for all Attendees"
	task :reinvite => :environment do

		attendees = User.where(:role_id => Role.find_by_title(:attendee))
		attendees.each do |a|
			a.status = :mass_attendee_reset_password
			a.send_reset_password_instructions
		end

	end

end
