class Allotment < ActiveRecord::Base
	
	include RankedModel
	
	# ranks :row_order

	attr_accessible	:period_id
	
	validates_uniqueness_of :period_id, :scope => [:allotable_id, :allotable_type], :message => "Abstract already assigned to Session"

	belongs_to	:period
	belongs_to	:allotable, :polymorphic => true
	
 ranks :row_order, :with_same => :period_id

end
