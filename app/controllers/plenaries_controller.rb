class PlenariesController < ApplicationController
  before_filter :authenticate_user!, :except=> [:show, :index]
  before_filter :getallextras
  before_filter :allconferences, :only => [:edit, :new]
  load_and_authorize_resource :except => [:index, :show]

  # GET /plenaries
  # GET /plenaries.json
  def index
    @plenaries = Plenary.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plenaries }
    end
  end

  # GET /plenaries/1
  # GET /plenaries/1.json
  def show
    @plenary = Plenary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plenary }
    end
  end

  # GET /plenaries/new
  # GET /plenaries/new.json
  def new
    @plenary = Plenary.new
    @plenary.user = current_user
    @plenary.attachments.build

    respond_to do |format|
      format.js
    end
  end

  # GET /plenaries/1/edit
  def edit
    @plenary = Plenary.find(params[:id])
  end

  # POST /plenaries
  # POST /plenaries.json
  def create
    @plenary = Plenary.new(params[:plenary])
    @plenary.user = current_user
    @plenary.attachments.build(params[:attachments])

    @plenary.save
    respond_to do |format|
      format.js
    end

  end

  # PUT /plenaries/1
  # PUT /plenaries/1.json
  def update
    @plenary = Plenary.find(params[:id])
    @plenary.update_attributes(params[:plenary])

    respond_to do |format|
      format.js
    end
  end

  # DELETE /plenaries/1
  # DELETE /plenaries/1.json
  def destroy
    @plenary = Plenary.find(params[:id])
    @plenary.destroy
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
    @conference = Conference.find(params[:conference_id])

  end

  def allconferences
    @xconfs = Conference.all
  end
end
