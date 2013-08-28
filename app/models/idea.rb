class Idea < ActiveRecord::Base

  attr_accessible :description

  belongs_to	:board
  belongs_to	:user

end
