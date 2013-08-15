class Comment < ActiveRecord::Base

  attr_accessible :category, :content

  belongs_to :submission
  belongs_to :user

end
