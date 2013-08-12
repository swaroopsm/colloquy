class PagecatsController < ApplicationController
  load_and_authorize_resource
  # GET /pagetypes
  # GET /pagetypes.json
  def index
    @pagecats = Pagecat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pagecats }
    end
  end

  # GET /pagetypes/1
  # GET /pagetypes/1.json
  def show
    @pagecat = Pagecat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @pagecat }
    end
  end

  # GET /pagetypes/new
  # GET /pagetypes/new.json
  def new
    @pagecat = Pagecat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @pagecat }
    end
  end

  # GET /pagetypes/1/edit
  def edit
    @pagecat = Pagecat.find(params[:id])
  end

  # POST /pagetypes
  # POST /pagetypes.json
  def create
    @pagecat = Pagecat.new(params[:pagetype])

    respond_to do |format|
      if @pagecat.save
        format.html { redirect_to @pagecat, notice: 'Pagetype was successfully created.' }
        format.json { render json: @pagecat, status: :created, location: @pagecat }
      else
        format.html { render action: "new" }
        format.json { render json: @pagecat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pagetypes/1
  # PUT /pagetypes/1.json
  def update
    @pagecat = Pagecat.find(params[:id])

    respond_to do |format|
      if @pagecat.update_attributes(params[:pagetype])
        format.html { redirect_to @pagecat, notice: 'Pagetype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @pagecat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagetypes/1
  # DELETE /pagetypes/1.json
  def destroy
    @pagecat = Pagecat.find(params[:id])
    @pagecat.destroy

    respond_to do |format|
      format.html { redirect_to pagetypes_url }
      format.json { head :no_content }
    end
  end
end
