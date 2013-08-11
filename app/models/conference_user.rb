class ConferenceUser < ActiveRecord::Base
  attr_accessible :conference_id, :user_id
end
