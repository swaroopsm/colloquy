class SchedulesController < ApplicationController
	
	before_filter :authenticate_user!
	before_filter :onlyboss
	
	def create
		@schedule = Schedule.new(params[:schedule])
		@schedule.conference = Conference.active
		@schedule.schedulable = find_schedulable

		# render :text => find_schedulable

		if @schedule.save
			respond_to do |format|
				format.js
			end
		end
	end

	def edit
		@schedule = Schedule.find(params[:id])
		if @schedule.schedulable.instance_of? Plenary
			@plenary = @schedule.schedulable
		elsif @schedule.schedulable.instance_of? Period
			@period = @schedule.schedulable
		else
			@workshop = @schedule.schedulable
		end

		respond_to do |format|
			format.js
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

	def onlyboss
		raise CanCan::AccessDenied unless current_user.admin?
	end

end
