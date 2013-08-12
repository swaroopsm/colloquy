class Workshop < ActiveRecord::Base
  attr_accessible :conference_id, :content, :presenter, :title
    belongs_to :conference
  	belongs_to :user
end
