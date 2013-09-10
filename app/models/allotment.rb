class Allotment < ActiveRecord::Base

	belongs_to	:period
	belongs_to	:allotable, :polymorphic => true

end
