class AttendeeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :onlyattendee
  before_filter :getallextras
  layout "attendee"
  def index
  end

  def workshops
    # @workshops = Workshop.all
    @workshops = Workshop.where(:conference_id => Conference.active)
  end



  private

  def onlyattendee
    raise CanCan::AccessDenied unless current_user.attendee?
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
