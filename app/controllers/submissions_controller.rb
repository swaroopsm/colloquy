class SubmissionsController < ApplicationController
  before_filter :getallextras
	before_filter :authenticate_user!, :except => [:show, :index, :talks, :posters]
	load_and_authorize_resource :conference, :except => [:new, :create, :talks, :posters]
	load_and_authorize_resource :submission, :through => :conference, :shallow => true,  :except => [:talks, :posters]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.where(:id => params[:id]).includes(:user).includes(:attachments).includes({:scores => [:user]}).includes(:comments)

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
    @submission = Submission.new
		@submission.attachments.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
    @submission.user = current_user
    @submission.conference = Conference.active
    @submission.attachments.build(params[:attachments]) if params[:attachments].present?

    respond_to do |format|
      if @submission.save
        format.html { redirect_to conference_submission_path(Conference.active, @submission), notice: 'Submission was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to submissions_url }
      format.json { head :no_content }
    end
  end

  def talks
    @submissions = Submission.where(:conference_id => Conference.active).where(:approved => '1')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  def posters
    @submissions = Submission.where(:conference_id => Conference.active).where(:approved => '2')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # This assigns a reviewer to an abstract
  def assign
		@reviewer = User.find(params[:user_id])
		@submission = Submission.find(params[:id])
		@assign = ReviewerSubmission.new
		@assign.user = @reviewer
		@assign.submission = @submission
		@assign.save
  end

  # This unassigns a reviewer from an abstract
  def unassign
		@unassign = ReviewerSubmission.find(params[:id])
		@unassign.destroy
  end

  private
  def getallextras
    @xpagecats = Pagecat.all
    @cats = []
    @xpagecats.each do | p |
      @cats << p.id
    end
    @xpages = Page.where("pagecat_id IN (?)", @cats ).where(:conference_id => Conference.active).group_by{ |c| c[:pagecat_id] }
    @conference = Conference.active
  end

  def allconferences
    @xconfs = Conference.all
  end

end
