class Score < ActiveRecord::Base

  attr_accessible :conservation, :recommendation, :science, :finalized

  belongs_to :user
  belongs_to :submission

end
