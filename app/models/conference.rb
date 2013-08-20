class Conference < ActiveRecord::Base
  attr_accessible :active, :description, :number_of_days, :start_date, :title, :venue, :online_registration_close, :workshop_registration_close, :workshop_registration_start, :abstract_submission_close, :abstract_submission_start, :early_bird_close

  extend FriendlyId
  friendly_id :title, use: :slugged

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
