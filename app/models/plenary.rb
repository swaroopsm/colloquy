class Plenary < ActiveRecord::Base
  attr_accessible :conference_id, :content, :presenter, :title, :user_id
end
