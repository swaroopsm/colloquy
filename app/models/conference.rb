class Conference < ActiveRecord::Base
  attr_accessible :active, :description, :number_of_days, :start_date, :title, :venue
end
