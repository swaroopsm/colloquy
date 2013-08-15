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

	## End Abstracts Populate


	## Reviewers Populate

	class Reviewer < ActiveRecord::Base
			# Load Database
			establish_connection(load_database)

			def self.all
				reviewers = []
				find_each do |a|
					reviewers << {:first_name => a.reviewerFirstName, :last_name => a.reviewerLastName, :email => a.reviewerEmail, :password => Devise.friendly_token[1..8]}
				end
				reviewers
			end
	end

	desc "Populate all reviewers"
	task :reviewer => :environment do

		reviewers = Reviewer.all
		reviewers.each do |r|
			u = User.new(r)
			if u.email == "vvinatha@gmail.com"
				u.email = "contact@arjunashankar.com"
			end
			u.role = Role.find_by_title(:reviewer)
			u.save
			if u.errors.any?
				puts "Error for #{u.email} - #{u.errors.full_messages}"
			end
		end

	end

	## End Reviewers Populate


	## Assign Abstracts to Reviewers

	class Assignment < ActiveRecord::Base

		self.table_name = "abstracts"
		establish_connection load_database

		def self.assign(attendee)
			attendee = Attendee.find_by_attendeeEmail(attendee.email)
			ab = where(:attendeeID => attendee)
			if ab.any?
				ab = ab.first
				reviewers = Reviewer.where("reviewerID IN (?)", [ab[:reviewer1], ab[:reviewer2], ab[:reviewer3]])
				data = {:abstract => ab, :reviewers => reviewers}
			else
				nil
			end
		end

	end

	desc "Assigns abstracts to reviewers"
	task :assign => :environment do
		role = Role.find_by_title(:attendee)
		users = User.where(:role_id => role)
		users.each do |u|
			ab = Assignment.assign(u)
			unless ab.nil?
				ab[:reviewers].each do |e|
					r = ReviewerSubmission.new
					if e.reviewerEmail == "vvinatha@gmail.com"
						r.user = User.find_by_email("contact@arjunashankar.com")
					else
						r.user = User.find_by_email(e.reviewerEmail)
					end
					r.submission = u.active_submission
					r.save
					if r.errors.any?
						p "Error for: #{r.user.email}"
						p r.errors.full_messages
					end
				end
			end
		end
	end

	## End Abstract Assignment


	## Populate Comments

	class OldComment < ActiveRecord::Base

		self.table_name = "comments"
		establish_connection load_database

		def self.comment(r)
			r = Reviewer.find_by_reviewerEmail(r.email)
			comment = where(:reviewerID => r)
			comments = []
			comment.each do |c|
				ab = OldAbstract.find(c.abstractID)
				comments << {
											:content => c.commentContent,
											:reviewer => r,
											:abstract => ab.abstractTitle,
											:category => c.commentType
										}
			end
			comments
		end

	end

	desc "Populates Comments"
	task :comment => :environment do

	reviewers = User.where(:role_id => Role.find_by_title(:reviewer))
	reviewers.each do |r|
		c = OldComment.comment(r)
		ab = 0;
		c.each do |cc|
			abs = Submission.find_by_title(cc[:abstract])
			comment = Comment.new
			comment.content = cc[:content]
			comment.user = r
			comment.submission = abs
			comment.category = cc[:category]
			comment.save
			if comment.errors.any?
				puts comment.errors.full_messages
			end
		end
	end

	end

	## End Populating Comments


	## Populate Comments

	class OldScore < ActiveRecord::Base

		self.table_name = "scores"
		establish_connection load_database

		def self.score(r)
			r = Reviewer.find_by_reviewerEmail(r.email)
			score = where(:reviewerID => r)
			scores = []
			score.each do |s|
				ab = OldAbstract.find(s.abstractID)
				actual_score = JSON.parse(s.score)
				scores << {
											:conservation => actual_score["conservation"],
											:science => actual_score["science"],
											:recommendation => s.recommendation,
											:finalized => s.reviewer_submitted,
											:abstract => ab.abstractTitle,
										}
			end
			scores
		end

	end

	desc "Populates Scores"
	task :score => :environment do

	reviewers = User.where(:role_id => Role.find_by_title(:reviewer))
	s = OldScore.score(reviewers.first)
	reviewers.each do |r|
		s = OldScore.score(r)
		s.each do |ss|
			abs = Submission.find_by_title(ss[:abstract])
			ss.delete :abstract
			score = Score.new(ss)
			score.user = r
			score.submission = abs
			score.save
			if score.errors.any?
				puts score.errors.full_messages
			end
		end
	end

	end

	## End Populating Scores



end
