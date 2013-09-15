class Schedule < ActiveRecord::Base
  attr_accessible :minutes, :schedulable_id, :schedulable_type, :starttime, :venue
end
