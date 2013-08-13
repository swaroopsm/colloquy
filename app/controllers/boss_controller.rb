class BossController < ApplicationController
	before_filter :authenticate_user!
	before_filter :onlyboss
	before_filter :getallextras
	layout "boss"

	def index

	end



	def pages
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
