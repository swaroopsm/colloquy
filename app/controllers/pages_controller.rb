class PagesController < ApplicationController
  before_filter :authenticate_user!, :except=> [:show, :index]
  before_filter :getallextras
  before_filter :allconferences, :only => [:edit, :new]
  load_and_authorize_resource :except => [:index, :show]


  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new
    @page.attachments.build
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.json { render json: @page }
    # end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])
    @page.user = current_user
    @page.attachments.build(params[:attachments])

    @page.save
    respond_to do |format|
      format.js
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    @page.update_attributes(params[:page])
    respond_to do |format|
      format.js
    end

    # respond_to do |format|
    #   if @page.update_attributes(params[:page])
    #     format.html { redirect_to @page, notice: 'Page was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #     format.json { render json: @page.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
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
