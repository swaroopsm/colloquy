class UsersController < ApplicationController
	before_filter :getallextras

	def participate
		tickets = []
		cur_ticket = params[:participate][:ticket]
		cur_email = params[:participate][:email]
		cur_user = nil
		cur_conference = Conference.active
		sync['participants'].each do |s|
			r = ConferenceUser.new
			r.ticket = s['Ticket_Number']
			r.conference = cur_conference
			tickets << r
			if s['Ticket_Number'] == cur_ticket and s['Email'] == cur_email
				cur_user = s
			end
		end
		ConferenceUser.import tickets

		# Find ticket and register the user
		@user = User.new
		unless cur_user.nil?
			if params[:participate][:email] == cur_user["Email"] and params[:participate][:ticket] == cur_user["Ticket_Number"]
				query_user = User.find_by_email(params[:participate][:email])
				if query_user.nil?
					@user.email = cur_user["Email"]
					@user.password = Devise.friendly_token[1..8]
					@user.first_name = cur_user["participant_information"][0]["info"]
					@user.last_name = cur_user["participant_information"][2]["info"]
					if @user.save

						# Register user for the conference
						ConferenceUser.find_by_ticket(params[:participate][:ticket])
						c.user = @user
						c.save

						# Populate User Detail
						@detail = Detail.new
						@detail.gender = cur_user["participant_information"][1]["info"]
						@detail.dob = cur_user["participant_information"][3]["info"]
						@detail.academic = cur_user["participant_information"][4]["info"]
						@detail.institute_affiliation = cur_user["participant_information"][5]["info"]
						@detail.address = cur_user["participant_information"][7]["info"]
						@detail.phone = cur_user["participant_information"][6]["info"]
						@detail.nationality = cur_user["participant_information"][8]["info"]
						@detail.user = @user
						@detail.save

						# Make sure the below line is uncommented when in production
						@user.status = :new_attendee
						@user.send_reset_password_instructions
					end
				else
					if query_user.reset_password_token.nil?
						# Make sure the below line is uncommented when in production
						query_user.status = :new_attendee
						query_user.send_reset_password_instructions
					else
						@user.errors.add(:base, "You have already registered for participation.")
					end
				end
			end
		else
			@user.errors.add(:base, "Invalid Email & Ticket Combination")
		end
		respond_to do |format|
			format.js
		end

	end

  private
  def getallextras
    @xpagecats = Pagecat.all
    @cats = []
    @xpagecats.each do | p |
      @cats << p.id
    end
    @xpages = Page.where("pagecat_id IN (?)", @cats ).where(:conference_id => Conference.active).group_by{ |c| c[:pagecat_id] }
  end

  def allconferences
    @xconfs = Conference.all
  end

  def sync
  	JSON.parse(RestClient.get(Doattend))
  end

end
