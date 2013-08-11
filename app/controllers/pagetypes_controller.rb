class PagetypesController < ApplicationController
  # GET /pagetypes
  # GET /pagetypes.json
  def index
    @pagetypes = Pagetype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pagetypes }
    end
  end

  # GET /pagetypes/1
  # GET /pagetypes/1.json
  def show
    @pagetype = Pagetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pagetype }
    end
  end

  # GET /pagetypes/new
  # GET /pagetypes/new.json
  def new
    @pagetype = Pagetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pagetype }
    end
  end

  # GET /pagetypes/1/edit
  def edit
    @pagetype = Pagetype.find(params[:id])
  end

  # POST /pagetypes
  # POST /pagetypes.json
  def create
    @pagetype = Pagetype.new(params[:pagetype])

    respond_to do |format|
      if @pagetype.save
        format.html { redirect_to @pagetype, notice: 'Pagetype was successfully created.' }
        format.json { render json: @pagetype, status: :created, location: @pagetype }
      else
        format.html { render action: "new" }
        format.json { render json: @pagetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pagetypes/1
  # PUT /pagetypes/1.json
  def update
    @pagetype = Pagetype.find(params[:id])

    respond_to do |format|
      if @pagetype.update_attributes(params[:pagetype])
        format.html { redirect_to @pagetype, notice: 'Pagetype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pagetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagetypes/1
  # DELETE /pagetypes/1.json
  def destroy
    @pagetype = Pagetype.find(params[:id])
    @pagetype.destroy

    respond_to do |format|
      format.html { redirect_to pagetypes_url }
      format.json { head :no_content }
    end
  end
end
