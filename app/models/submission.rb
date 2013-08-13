class Submission < ActiveRecord::Base
  attr_accessible :approved, :authors, :bursary_for, :bursary_why, :conference_id, :content, :preference, :title, :user_id
end
