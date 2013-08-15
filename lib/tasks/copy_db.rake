namespace :copy_db do

	def load_database
		config = {
			:adapter => "mysql2",
			:encoding => "utf8",
			:username => "root",
			:password => "swvist",
			:host => "localhost",
			:database => "sccs_bng_org"
		}
	end

	## Attendees Populate

	class Attendee < ActiveRecord::Base
			# Load Database
			establish_connection(load_database)

			def self.all
				attendees = []
				find_each do |a|
					attendees << {:first_name => a.attendeeFirstName, :last_name => a.attendeeLastName, :email => a.attendeeEmail, :password => Devise.friendly_token[1..8]}
				end
				attendees
			end

			def self.detail(attendee)
				a = find_by_attendeeEmail(attendee.email)
				detail = {
												:gender => a.attendeeGender,
												:dob => a.attendeeDOB,
												:academic => a.attendeeAcademic,
												:institute_affiliation => a.attendeeInstAffiliation,
												:address => a.attendeeAddress,
												:phone => a.attendeePhone,
												:nationality => a.attendeeNationality,
												:passport => a.attendeePassport,
								}
				detail
			end

			def self.ticket(attendee)
				a = find_by_attendeeEmail(attendee.email)
				ticket = a.attendeeTicket
			end

		end

	desc "Copies and Migrates from attendees email and name database"
	task :attendees => :environment do

		c = 1
		Attendee.all.each do |a|
			puts "Populating #{c}/#{Attendee.all.size}"
			u = User.new(a)
			u.role = Role.find_by_title(:attendee)
			u.save
			if u.errors.any?
				puts "Error for: #{u.first_name}. #{u.errors.full_messages}"
			end
			c += 1
		end

	end

	desc "Copies and Migrates details of attendees"
	task :attendee_details => :environment do

		attendees = User.all
		c = 1
		attendees.each do |a|
			puts "Populating #{c}/#{attendees.size}"
			u = Attendee.detail(a)
			d = Detail.new(u)
			d.user = a
			d.save
			c += 1
		end

	end

	desc "Registers users for the current conference"
	task :attendee_register => :environment do

		attendees = User.all
		count = 1
		attendees.each do |a|
			puts "Populating #{count}/#{attendees.size}"
			c = ConferenceUser.new
			c.conference = Conference.active
			c.user = a
			c.ticket = Attendee.ticket(a)
			c.save
			count += 1
		end
	end

	## End Attendees Populate


	## Page Populate

	class OldPage < ActiveRecord::Base

		self.table_name = "pages"
		# Load Database
		establish_connection(load_database)

		def self.all
			p = where(:pageType => 1)
			pages = []
			p.each do |pp|
				pages << {
										:title => pp.pageTitle,
										:content => pp.pageContent,
										:active => true
								 }
			end
			pages
		end

	end

	desc "Populate all pages"
	task :page => :environment do

		admin = Role.find_by_title(:admin)
		pages = OldPage.all
		pages.each do |p|
			page = Page.new(p)
			page.user = User.where(:role_id => admin).first
			page.conference = Conference.active
			page.pagecat = Pagecat.first
			page.save
			if page.errors.any?
				puts page.errors.full_messages
			end
		end

	end

	## End Page Populate


	## Plenary Populate

	class OldPlenary < ActiveRecord::Base

		self.table_name = "pages"
		# Load Database
		establish_connection(load_database)

		def self.all
			p = where(:pageType => 2)
			pages = []
			p.each do |pp|
				pages << {
										:title => pp.pageTitle,
										:content => pp.pageContent,
										:presenter => pp.pageSubHeading
								 }
			end
			pages
		end

	end

	desc "Populate all plenaries"
	task :plenary => :environment do

		admin = Role.find_by_title(:admin)
		pages = OldPlenary.all
		pages.each do |p|
			page = Plenary.new(p)
			page.user = User.where(:role_id => admin).first
			page.conference = Conference.active
			page.save
			if page.errors.any?
				puts page.errors.full_messages
			end
		end

	end

	## End Plenary Populate


	## Workshop Populate

	class OldWorkshop < ActiveRecord::Base

		self.table_name = "pages"
		# Load Database
		establish_connection(load_database)

		def self.all
			p = where(:pageType => 3)
			pages = []
			p.each do |pp|
				pages << {
										:title => pp.pageTitle,
										:content => pp.pageContent,
										:presenter => pp.pageSubHeading
								 }
			end
			pages
		end

	end

	desc "Populate all workshops"
	task :workshop => :environment do

		admin = Role.find_by_title(:admin)
		pages = OldWorkshop.all
		pages.each do |p|
			page = Workshop.new(p)
			page.user = User.where(:role_id => admin).first
			page.conference = Conference.active
			page.save
			if page.errors.any?
				puts page.errors.full_messages
			end
		end

	end

	## End Workshop Populate


	## Abstracts Populate

	class OldAbstract < ActiveRecord::Base

		self.table_name = "abstracts"
		# Load Database
		establish_connection(load_database)

		def self.all_abstracts
			a = all
			abstracts = []
			a.each do |aa|
				bursary = JSON.parse(aa.bursary)
				content = JSON.parse(aa.abstractContent)
				attendee = Attendee.find(aa.attendeeID)
				accomodation = false
				accomodation = true if bursary["accomodation"].strip.downcase == "yes"
				abstracts << {
										:title => aa.abstractTitle,
										:authors => aa.abstractAuthors,
										:aim => content["aim"],
										:methods => content["methods"],
										:results => content["results"],
										:conservation => content["conservation"],
										:preference => aa.attendeePreference,
										:approved => aa.approved,
										:attendee => attendee.attendeeEmail,
										:bursary_for => bursary["bursary_for"],
										:bursary_why => bursary["bursary_why"],
										:accomodation => accomodation
								 }
			end
			abstracts
		end

	end

	desc "Populate all submissions"
	task :abstract => :environment do


		OldAbstract.all_abstracts.each do |a|
			attendee = a[:attendee]
			attendee = User.find_by_email(attendee)
			approved = a[:approved]
			a.delete :attendee
			a.delete :approved
			s = Submission.new(a)
			s.user = attendee
			s.approved = approved
			s.conference = Conference.active
			s.save
			if s.errors.any?
				p "Error #{s.title} - #{s.errors.full_messages}"
			end
		end

	end

	## End Page Populate

end
