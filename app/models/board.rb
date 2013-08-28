class Board < ActiveRecord::Base

  attr_accessible :description, :title

  belongs_to	:user
  belongs_to	:conference

end
