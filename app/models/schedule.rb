class Schedule < ActiveRecord::Base
  attr_accessible :minutes, :starttime, :venue

  belongs_to :schedulable, :polymorphic => true
 
end
