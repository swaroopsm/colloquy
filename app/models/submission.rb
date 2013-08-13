class Submission < ActiveRecord::Base

  attr_accessible :approved, :authors, :bursary_for, :bursary_why, :content, :preference, :title

	belongs_to :user
	belongs_to :conference

end
