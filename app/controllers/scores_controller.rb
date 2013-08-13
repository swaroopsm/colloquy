class ScoresController < ApplicationController

	before_filter :authenticate_user!
	load_and_authorize_resource

	def create
		@score = Score.new(params[:score])
		@score.submission = Submission.find(params[:submission_id])
		@score.user = current_user
		@score.save
	end

end
