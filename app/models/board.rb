class Board < ActiveRecord::Base

  attr_accessible :description, :title

  belongs_to	:user
  belongs_to	:conference
  has_many		:ideas

end
