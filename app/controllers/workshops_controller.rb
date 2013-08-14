class WorkshopsController < ApplicationController
  before_filter :authenticate_user!, :except=> [:show, :index]
  before_filter :getallextras, :only => [:index, :show]
  before_filter :allconferences, :only => [:edit, :new]
  load_and_authorize_resource :except => [:index, :show]

  # GET /workshops
  # GET /workshops.json
  def index
    @workshops = Workshop.all
    @conference = Conference.find(params[:conference_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @workshops }
    end
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshop = Workshop.find(params[:id])
    @attendees = @workshop.attendees
    @conference = Conference.find(params[:conference_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @workshop }
    end
  end

  # GET /workshops/new
  # GET /workshops/new.json
  def new
    @workshop = Workshop.new
    @workshop.attachments.build

    respond_to do |format|
      format.js
    end
  end

  # GET /workshops/1/edit
  def edit
    @workshop = Workshop.find(params[:id])
    @conference = Conference.find(params[:conference_id])
    respond_to do |format|
      format.js
    end
  end

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = Workshop.new(params[:workshop])
    @workshop.user = current_user
    @workshop.attachments.build(params[:attachments])
    @workshop.conference = Conference.active

    respond_to do |format|
      if @workshop.save
        format.js
      end
    end
  end

  # PUT /workshops/1
  # PUT /workshops/1.json
  def update
    @workshop = Workshop.find(params[:id])
    # @workshop.attachments.build(params[:attachments])

    @workshop.update_attributes(params[:workshop])
    
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop = Workshop.find(params[:id])
    @workshop.destroy

    respond_to do |format|
      format.html { redirect_to workshops_url }
      format.json { head :no_content }
    end
  end

  # Attend the workshop
  def attend
    @workshop = Workshop.find(params[:workshop_id])
    @workshop_attendee = WorkshopAttendee.new
    @workshop_attendee.user = current_user
    @workshop_attendee.workshop = @workshop
    if @workshop_attendee.save
      respond_to do |format|
        format.js
      end
    end
  end

   # Unattend the workshop
  def unattend
    @workshop = Workshop.find(params[:workshop_id])
    @workshop_attendee = WorkshopAttendee.where(:user_id => current_user, :workshop_id => @workshop)
    @workshop_attendee[0].destroy
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


end
