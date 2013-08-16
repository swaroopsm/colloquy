class Submission < ActiveRecord::Base

  attr_accessible :authors, :bursary_for, :bursary_why, :preference, :title, :accomodation,
  								:aim, :methods, :results, :conservation # Virtual Attributes
  attr_accessor   :aim, :methods, :results, :conservation # Virtual Attributes

  before_save :full_content

	validates_presence_of :authors, :preference, :title,
												:aim, :methods, :results, :conservation # Virtual Attributes

	belongs_to	:user
	belongs_to  :conference
	has_many 		:attachments, :as => :attachable
	has_many		:reviewers, :class_name => "ReviewerSubmission"
	has_many		:scores
	has_many		:comments

  accepts_nested_attributes_for :attachments

	# Check if an abstract has been approved for a talk or a poster
	def approved?
		approval = [1,2]
		!self.approved.nil? or approval.include? self.approved
	end

  private
  def full_content
  	# Change this according to the client's need of abstract fields
  	attrs = [:aim, :methods, :results, :conservation]

  	content = ""
  	attrs.each do |a|
  		div_start = "<div class='content_breakup'><h2>#{a.capitalize}</h2>"
	  	div_end = "</div>"
			content += div_start + self.send(a) + div_end
  	end
		self.content = content
  end

end
