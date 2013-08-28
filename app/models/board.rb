class Board < ActiveRecord::Base

  attr_accessible :text, :title

  belongs_to	:user
  belongs_to	:conference

end
