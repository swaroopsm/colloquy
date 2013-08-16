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
	    @plenaries = Plenary.all
	end

	def attendees
	    @attendees = User.where(:role => "attendee").where(:conference_id => Conference.active)
	end

	def workshops
		@workshops = Workshop.all
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

	# list all the scheduled things
	def schedules
		@schedules = Schedule.all
	end


  # This will render the email form
  def emailform
  end

  # This will actually send the mail
  def sendemailtoattendees
  	@users = User.all

  	@sub = params[:emailbody]
  	@getname = @sub.sub("@@Name@@", "blah" )

  	render :text => @getname.to_json

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
