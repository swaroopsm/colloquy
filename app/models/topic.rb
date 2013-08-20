class Topic < ActiveRecord::Base

	extend FriendlyId
	friendly_id :title, use: :slugged

  attr_accessible :description, :title

  belongs_to :conference
  belongs_to :user

end
