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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @period }
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

    respond_to do |format|
      if @period.update_attributes(params[:period])
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period = Period.find(params[:id])
    @period.destroy

    respond_to do |format|
      format.html { redirect_to periods_url }
      format.json { head :no_content }
    end
  end
end
