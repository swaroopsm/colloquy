class PlenariesController < ApplicationController
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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plenary }
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

    respond_to do |format|
      if @plenary.save
        format.html { redirect_to @plenary, notice: 'Plenary was successfully created.' }
        format.json { render json: @plenary, status: :created, location: @plenary }
      else
        format.html { render action: "new" }
        format.json { render json: @plenary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plenaries/1
  # PUT /plenaries/1.json
  def update
    @plenary = Plenary.find(params[:id])

    respond_to do |format|
      if @plenary.update_attributes(params[:plenary])
        format.html { redirect_to @plenary, notice: 'Plenary was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plenary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plenaries/1
  # DELETE /plenaries/1.json
  def destroy
    @plenary = Plenary.find(params[:id])
    @plenary.destroy

    respond_to do |format|
      format.html { redirect_to plenaries_url }
      format.json { head :no_content }
    end
  end
end
