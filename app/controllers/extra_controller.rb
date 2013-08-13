class ExtraController < ApplicationController
	



  private
  def getallextras
    @xpagecats = Pagecat.all
    @cats = []
    @xpagecats.each do | p |
      @cats << p.id
    end
    @xpages = Page.where("pagecat_id IN (?)", @cats ).group_by{ |c| c[:pagecat_id] }
  end

  def allconferences
    @xconfs = Conference.all
  end
end