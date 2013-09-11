class Period < ActiveRecord::Base
  
  attr_accessible :title

	belongs_to	:conference
	has_many		:submissions, :class_name => "Allotment"

end
