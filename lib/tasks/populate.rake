namespace :populate do

	desc "This invokes all the tasks of copy_db task"
	task :fire => :environment do

		# Create admin
		u = User.new(:first_name => "SCCS", :last_name => "Boss", :email => "admin@sccs-bng.org", :password => "12345678")
		u.role = Role.find_by_title(:admin)
		u.save

		# Create Conference
		c = Conference.new
		c.title = "SCCS BNG 2013"
		c.description = "Students' Conference of Conservative Science"
		c.start_date = "2013-09-21"
		c.number_of_days = 4
		c.venue = "IISc. Bangalore"
		c.active = true
		c.save

		# Default Page Category
		p = Pagecat.new
		p.title = "Information for Presenters"
		p.save

		Rake::Task["copy_db:attendees"].invoke
		Rake::Task["copy_db:attendee_details"].invoke
		Rake::Task["copy_db:attendee_register"].invoke

		Rake::Task["copy_db:page"].invoke

		Rake::Task["copy_db:plenary"].invoke

		Rake::Task["copy_db:workshop"].invoke

		Rake::Task["copy_db:abstract"].invoke

		Rake::Task["copy_db:reviewer"].invoke

		Rake::Task["copy_db:assign"].invoke

		Rake::Task["copy_db:comment"].invoke

		Rake::Task["copy_db:score"].invoke

	end

end
