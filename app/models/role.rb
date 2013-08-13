class Role < ActiveRecord::Base
  attr_accessible :title

	validates_uniqueness_of :title

  has_many :users

end
