class ReviewerSubmission < ActiveRecord::Base

  belongs_to :user
  belongs_to :submission

  validate :reviewer_check, :on => :create

  private
  def reviewer_check
  	errors.add(:base, "You can only assign a reviewer to an abstract") unless self.user.reviewer?
  	errors,add(:base, "You have already assigned this abstract to the reviewer") if ReviewerSubmission.where(:user_id => self.user, :submission_id => self.submission).size > 0
  end

end
