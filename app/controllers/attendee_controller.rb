class AttendeeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :onlyattendee
  before_filter :getallextras
  layout "attendee"
  def index

  end

  def workshops
    # @workshops = Workshop.all
    @scheduled_w = Schedule.where(:schedulable_type => 'Workshop').includes({:schedulable => :workshop_attendees})
    days = @conference.number_of_days

    @days = []
    while days > 0
      @days << Workshop.has_registered_for_day(current_user, days)
      days -= 1
    end

    @grouped = @scheduled_w.group_by{|d| d[:day]}
    # @workshops = Workshop.where(:conference_id => Conference.active).includes(:workshop_attendees)
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
    @submission = Submission.where(:user_id => current_user)

  end

  def allconferences
    @xconfs = Conference.all
  end

end
