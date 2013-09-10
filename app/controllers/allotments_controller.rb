class AllotmentsController < ApplicationController

	before_filter	:authenticate_user!
	load_and_authorize_resource

	def new
		@periods = Period.all
		@submission = Submission.find(params[:submission_id])

		respond_to do |format|
			format.js
		end
	end

end
