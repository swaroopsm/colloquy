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

	def create
		@allotment = Allotment.new
		@period = Period.find(params[:allotment][:period_id])
		
		@allotment.period = @period
		@allotment.allotable = find_allotable

		@allotment.save

		respond_to do |format|
			format.js
		end

	end

	def edit
		@allotment = Allotment.find(params[:allotment_id])
		@periods = Period.all
		
		respond_to do |format|
			format.js
		end
	end

	def update
		@allotment = Allotment.find(params[:allotment_id])
		@allotment.period = Period.find(params[:allotment][:period_id])
		@allotment.save
		
		respond_to do |format|
			format.js
		end
	end

	def destroy
		@allotment = Allotment.find(params[:allotment_id])
		@allotment.destroy

		respond_to do |format|
			format.js
		end
	end
	
	private
	def find_allotable
		params.each do |name, value|
			if name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
		nil
	end

end
