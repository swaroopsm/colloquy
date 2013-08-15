class Comment < ActiveRecord::Base
  attr_accessible :category, :content, :submission_id, :user_id
end
