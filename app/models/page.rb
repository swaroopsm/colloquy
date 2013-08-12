class Page < ActiveRecord::Base
  attr_accessible :active, :content, :title, :conference_id, :pagecat_id

  belongs_to :conference
  belongs_to :user
  belongs_to :pagecat
end
