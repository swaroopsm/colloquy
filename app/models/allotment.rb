class Allotment < ActiveRecord::Base
	
	attr_accessible	:period_id

	belongs_to	:period
	belongs_to	:allotable, :polymorphic => true

end
