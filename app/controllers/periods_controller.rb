class PeriodsController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @periods }
    end
  end

  # GET /periods/1
  # GET /periods/1.json
  def show
    @period = Period.find(params[:id])
    @submissions = Allotment.where(:period_id => @period).order(:row_order).includes({ :allotable => :user })

    respond_to do |format|
      format.js
    end
  end

  # GET /periods/new
  # GET /periods/new.json
  def new
  	@conference = Conference.find(params[:conference_id])
    @period = Period.new

    respond_to do |format|
      format.js
    end
  end

  # GET /periods/1/edit
  def edit
  	@conference = Conference.find(params[:conference_id])
    @period = Period.find(params[:id])

    respond_to do |format|
			format.js
		end
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(params[:period])
    @period.conference = Conference.find(params[:conference_id])
		@period.save

    respond_to do |format|
    	format.js
    end
  end

  # PUT /periods/1
  # PUT /periods/1.json
  def update
    @period = Period.find(params[:id])
    @period.update_attributes(params[:period])
		
		respond_to do |format|
			format.js
		end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period = Period.find(params[:id])
    @submissions = Allotment.where(:period_id => @period)
    @submissions.delete_all
    @period.destroy

    respond_to do |format|
      format.js
    end
	end

	def submissions
		@period = Period.find(params[:period_id])
		@allotments = Allotment.where(:period_id => @period).rank(:row_order).includes(:allotable)
		
		respond_to do |format|
			format.js
		end
	end

end
