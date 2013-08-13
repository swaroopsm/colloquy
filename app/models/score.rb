class Score < ActiveRecord::Base
  attr_accessible :conservation, :recommendation, :science, :submission_id, :user_id
end
