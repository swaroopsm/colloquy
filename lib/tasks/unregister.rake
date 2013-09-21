namespace :unregister do
	
	task :attendees => :environment do
		
		attendees = ["ganeshlanke786@gmail.com", "daminichavan.chavan@gmail.com", "alphonsopriya25@gmail.com", "neeraj.mahar88@gmail.com"]

		attendees.each do |a|
			u = User.find_by_email(a)
			u.detail.destroy
			u.submissions.first.scores.delete_all
			u.submissions.first.reviewers.delete_all
			u.submissions.first.attachments.delete_all
			u.workshops.delete_all
		end

	end

end
