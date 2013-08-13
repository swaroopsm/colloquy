class Submission < ActiveRecord::Base

  attr_accessible :authors, :bursary_for, :bursary_why, :content, :preference, :title

	belongs_to :user
	belongs_to :conference
	has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

end
