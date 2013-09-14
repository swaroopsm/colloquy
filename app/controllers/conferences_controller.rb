class ConferencesController < ApplicationController
  before_filter :authenticate_user!, :except=> [:show, :index]
  load_and_authorize_resource :except => [:index, :show]


  # GET /conferences
  # GET /conferences.json
  def index
    @conferences = Conference.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conferences }
    end
  end

  # GET /conferences/1
  # GET /conferences/1.json
  def show
    @conference = Conference.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conference }
    end
  end

  # GET /conferences/new
  # GET /conferences/new.json
  def new
    @conference = Conference.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @conference }
    end
  end

  # GET /conferences/1/edit
  def edit
    @conference = Conference.find(params[:id])
  end

  # POST /conferences
  # POST /conferences.json
  def create
    @conference = Conference.new(params[:conference])

    respond_to do |format|
      if @conference.save
        format.js
      end
    end
  end

  # PUT /conferences/1
  # PUT /conferences/1.json
  def update
    @conference = Conference.find(params[:id])

    respond_to do |format|
      if @conference.update_attributes(params[:conference]) and @conference.save
        format.js
      end
    end
  end

  # DELETE /conferences/1
  # DELETE /conferences/1.json
  def destroy
    @conference = Conference.find(params[:id])
    @conference.destroy

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
