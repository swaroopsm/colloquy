class Plenary < ActiveRecord::Base
  attr_accessible :conference_id, :content, :presenter, :title, :user_id
  belongs_to :conference
  belongs_to :user
end
