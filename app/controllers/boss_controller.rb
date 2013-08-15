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
		@schedule = Schedule.new(params[:schedule])
		@schedule.schedulable = @workshop

		if @schedule.save
			respond_to do |format|
				format.js 
			end
		end
	end

	def schedule_plenaries
		@plenaries = Plenary.all
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
