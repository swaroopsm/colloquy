class Period < ActiveRecord::Base
  
  attr_accessible :title, :category, :content
	
	NORMAL_SESSION = 1
	SPECIAL_SESSION = 2
	BREAK_SESSION = 3

	belongs_to	:conference
	has_many		:submissions, :class_name => "Allotment", :foreign_key => :period_id

end
