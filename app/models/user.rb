class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body


  has_many :conferences, :class_name=>"ConferenceUser"
  has_many :pages
  has_many :plenaries
  has_many :workshops
  has_many :submissions

  belongs_to :role

	# Check role of a user
		def admin?
		self.role.name == "admin"
	end

	def attendee?
		self.role.name == "attendee"
	end

	def reviewer?
		self.role.name == "reviewer"
	end


end
