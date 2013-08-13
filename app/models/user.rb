class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body


  has_many	:conferences, :class_name=>"ConferenceUser"
  has_many  :pages
  has_many  :plenaries
  has_many  :workshops
  has_many  :submissions
  has_many  :reviews, :class_name => "ReviewerSubmission"
  has_many	:scores

  belongs_to :role

	# Check role of a user
		def admin?
		self.role.title == "admin"
	end

	def attendee?
		self.role.title == "attendee"
	end

	def reviewer?
		self.role.title == "reviewer"
	end

	# Check if a user has submitted a conference for the current/active conference
	def submitted?
		s = Submission.where(:user_id => self, :conference_id => Conference.active)
		s.size > 0
	end

	# Check if user is registered for current/active conference
	def registered?
		ConferenceUser.where(:user_id => self, :conference_id => Conference.active).size > 0
	end
end
