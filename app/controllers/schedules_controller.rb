class SchedulesController < ApplicationController

	def create
		@schedule.conference = Conference.active
		@schedule = Schedule.new(params[:schedule])
		@schedule.schedulable = find_schedulable

		# render :text => find_schedulable

		if @schedule.save
			respond_to do |format|
				format.js
			end
		end
	end

	private
	def find_schedulable
		params.each do |name, value|
			if name =~ /(.+)_id$/
			  return $1.classify.constantize.find(value)
			end
		end
	end

end
