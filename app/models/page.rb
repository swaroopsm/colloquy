class Page < ActiveRecord::Base
  attr_accessible :active, :content, :title, :conference_id, :pagecat_id

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :conference
  belongs_to :user
  belongs_to :pagecat

  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments

  validates_presence_of :conference_id, :title, :active
end
