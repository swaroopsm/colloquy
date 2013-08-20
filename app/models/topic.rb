class Topic < ActiveRecord::Base

  attr_accessible :description, :title

  belongs_to :conference
  belongs_to :user

end
