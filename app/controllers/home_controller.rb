class HomeController < ApplicationController
	before_filter :getallextras

  def index
  	@workshops = Workshop.order('RAND()').includes(:attachments).all
    @plenaries = Plenary.order('RAND()').all
  end

	def participate

	end

	def schedule
		@schedules = Schedule.where(:conference_id => @conference).order(:day,:starttime).includes(:schedulable).group_by{ |s| s[:day] }
	end

  private
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
