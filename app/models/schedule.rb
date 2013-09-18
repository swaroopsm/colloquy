class Schedule < ActiveRecord::Base
  attr_accessible :minutes, :starttime, :venue, :day

  belongs_to :schedulable, :polymorphic => true
	
	validates_presence_of	:day
	validates_presence_of	:starttime
	validates_presence_of	:minutes
	validates_presence_of	:venue
	validate :duplicate, :on => :create

	private
	def duplicate
		model_name = self.schedulable_type == 'Period' ? "Session" : self.schedulable_type
		errors.add(:base, "You have already scheduled this #{model_name} for that day") if Schedule.exists? :schedulable_id => self.schedulable_id, :schedulable_type => self.schedulable_type, :day => self.day
	end

end
