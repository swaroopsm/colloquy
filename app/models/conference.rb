class Conference < ActiveRecord::Base
  attr_accessible :active, :description, :number_of_days, :start_date, :title, :venue

  has_many :users, :class_name => "ConferenceUser"
  has_many :pages
  has_many :plenaries
  has_many :workshops
  has_many :submissions

  def self.active
  	c = Conference.find_by_active(true)
  	c
  end
end
