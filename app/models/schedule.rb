class Schedule < ActiveRecord::Base
  attr_accessible :minutes, :starttime, :venue, :day

  belongs_to :schedulable, :polymorphic => true

end
