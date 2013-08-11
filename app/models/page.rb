class Page < ActiveRecord::Base
  attr_accessible :active, :content, :title

  belongs_to :conference
  belongs_to :user
end
