class BossController < ApplicationController
	before_filter :authenticate_user!
	before_filter :onlyboss
	before_filter :getallextras
	layout "boss"

	def index
	end

	def conferences
		@conferences = Conference.all
	end

	def pages
		@pages = Page.all
	end

	def plenaries
	    @plenaries = Plenary.includes(:attachments).all
	end

	def attendees
	    @attendees = ConferenceUser.where(:conference_id => Conference.active).includes({:user => :detail})
	end

	def workshops
		@workshops = Workshop.all
	end
	
	# list all sessions
	def sessions_list
		@periods = Period.includes(:submissions).all
	end

	# list abstract submissions that are pending from session assignment
	def sessions_submissions
		@submissions = Submission.non_allotted(@conference)
	end
	
	# list all allotted sessions on abstracts
	def allotments
		@allotments = Allotment.all
	end

	# list workshops for scheduling
	def schedule_workshops
		@workshops = Workshop.all
		@schedule = Schedule.new
	end

	# schedule the workshop
	def schedule_workshop
		@workshop = Workshop.find(params[:workshop_id])
		@schedule = Schedule.new
	end

	# list plenaries for scheduling
	def schedule_plenaries
		@plenaries = Plenary.all
	end

	# schedule the plenary
	def schedule_plenary
		@plenary = Plenary.find(params[:plenary_id])
		@schedule = Schedule.new
	end

	# list sessions for scheduling
	def schedule_periods
		@periods = Period.all
	end
	
	# schedule the plenary
	def schedule_period
		@period = Period.find(params[:period_id])
		@schedule = Schedule.new
	end

	# list all the scheduled things
	def schedules
		@schedules = Schedule.includes(:schedulable).all
	end

  def submissions
    @submission = Submission.where(:conference_id => Conference.active).includes(:user).includes(:scores).includes({:reviewers => :user})
  end

  def makerepeatableworkshop

  end


  # This will render the email form
  def emailform
  end

  # This will actually send the mail
  def sendemailtoattendees
  	@users = User.where(:role_id => Role.find_by_title(:attendee))
  	@sub = params[:emailbody]

    @array = []

    @users.each do |u|
      @getname = @sub.sub("@@Name@@", "#{u.first_name} #{u.last_name}" )
      @array << @getname
      UserMailer.delay.attendee_mail(u, @getname)
    end
    #render :text => @array.to_json
    respond_to do |format|
    	format.js
    end


  end

	# Display attendee details
	def attendees_show
		@attendee = User.find(params[:user_id])
		@ticket = ConferenceUser.where(:user_id => @attendee, :conference_id => Conference.active).first
  end


  # New Attendee
  def new_attendee
  	@attendee = User.new
  	@attendee.build_detail
  	respond_to do |format|
  		format.js
  	end
  end

  # Creates an attendee
  def create_attendee
  	@attendee = User.new(params[:user])
  	@attendee.password = Devise.friendly_token[1..8]
  	@attendee.build_detail(params[:detail])
  	@attendee.status = :new_attendee
		if @attendee.save
			c = ConferenceUser.new
			c.conference = Conference.active
			c.user = @attendee
			c.ticket = ConferenceUser.lowest_ticket.to_i - 2
			c.save
			@attendee.send_reset_password_instructions
		end
		respond_to do |format|
			format.js
		end
  end


	private

	def onlyboss
		raise CanCan::AccessDenied unless current_user.admin?
	end

	def getallextras
    @xpagecats = Pagecat.all
    @cats = []
    @xpagecats.each do | p |
      @cats << p.id
    end
    @xpages = Page.where("pagecat_id IN (?)", @cats ).where(:conference_id => Conference.active).group_by{ |c| c[:pagecat_id] }
    @conference = Conference.active
  end

  def allconferences
    @xconfs = Conference.all
  end
end
