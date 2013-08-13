class ScoresController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource :submission
	load_and_authorize_resource :score, :through => :submission

	def create
		@score = Score.new(params[:score])
		@score.submission = Submission.find(params[:submission_id])
		@score.user = current_user
		@score.save
	end

	def new

	end
end
