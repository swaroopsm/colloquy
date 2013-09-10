class Period < ActiveRecord::Base
  
  attr_accessible :title

	belongs_to	:conference

end
