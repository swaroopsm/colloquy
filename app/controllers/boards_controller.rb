class BoardsController < ApplicationController

  before_filter :getallextras
	before_filter :authenticate_user!, :except => [:index, :show]
	load_and_authorize_resource :except => [:index, :show]

  # GET /boards
  # GET /boards.json
  def index
    @boards = Board.where(:conference_id => @conference).includes(:user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boards }
    end
  end

  # GET /boards/1
  # GET /boards/1.json
  def show
    @board = Board.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/new
  # GET /boards/new.json
  def new
    @board = Board.new

    respond_to do |format|
      format.js # new.js.erb
      format.json { render json: @board }
    end
  end

  # GET /boards/1/edit
  def edit
    @board = Board.find(params[:id])
    respond_to do |format|
    	format.js
    end
  end

  # POST /boards
  # POST /boards.json
  def create
  	@conference = Conference.find(params[:conference_id])
    @board = Board.new(params[:board])
    @board.user = current_user
    @board.conference = @conference

		@board.save
    respond_to do |format|
			format.js
    end
  end

  # PUT /boards/1
  # PUT /boards/1.json
  def update
    @board = Board.find(params[:id])

    respond_to do |format|
      if @board.update_attributes(params[:board])
        format.js
      else
        format.js
      end
    end
  end

  # DELETE /boards/1
  # DELETE /boards/1.json
  def destroy
    @board = Board.find(params[:id])
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url }
      format.json { head :no_content }
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

end
