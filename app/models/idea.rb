class Idea < ActiveRecord::Base
  attr_accessible :board_id, :description, :user_id
end
