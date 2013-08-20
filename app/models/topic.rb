class Topic < ActiveRecord::Base
  attr_accessible :conference_id, :description, :title, :user_id
end
