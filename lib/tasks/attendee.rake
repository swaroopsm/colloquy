namespace :attendee do

	desc "Resets Passwords for all Attendees"
	task :reinvite => :environment do

		attendees = User.where(:role_id => Role.find_by_title(:attendee), :sign_in_count => 0)
		attendees.each do |a|
			p "Emailing: #{a.email}"
			a.status = :mass_attendee_reset_password
			a.send_reset_password_instructions
		end

	end

end
