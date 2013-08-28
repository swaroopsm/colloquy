class Plenary < ActiveRecord::Base
  attr_accessible :conference_id, :content, :presenter, :title
  belongs_to :conference
  belongs_to :user
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

  validates_presence_of :conference

  extend FriendlyId
  friendly_id :title, use: :slugged
end
