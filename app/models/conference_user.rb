class ConferenceUser < ActiveRecord::Base
  attr_accessible :conference_id, :user_id

  belongs_to :conference
  belongs_to :user

#  validates_uniqueness_of :ticket

end
