class Page < ActiveRecord::Base
  attr_accessible :active, :content, :title, :conference

  belongs_to :conference
  belongs_to :user
end