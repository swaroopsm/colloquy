class Detail < ActiveRecord::Base
  attr_accessible :academic, :address, :dob, :gender, :institute_affiliation,
  								:nationality, :passport, :phone

  belongs_to :user

end
