class Score < ActiveRecord::Base

  attr_accessible :conservation, :recommendation, :science

  belongs_to :user
  belongs_to :submission

end
