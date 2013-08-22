class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body

  attr_accessor :status


  has_many	:conferences, :class_name=>"ConferenceUser"
  has_many  :pages
  has_many  :plenaries
  has_many  :workshops
  has_many  :submissions
  has_many  :reviews, :class_name => "ReviewerSubmission"
  has_many	:scores
  has_many  :comments
  has_many	:ideas
  has_many	:topics

  has_many :workshop_attendees
  has_one	 :detail
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

	# Get abstract of the current conference of an attendee
	def active_submission
		s = Submission.where(:user_id => self, :conference_id => Conference.active).first
	end

end
