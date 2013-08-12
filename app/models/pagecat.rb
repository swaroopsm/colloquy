class Pagecat < ActiveRecord::Base
  attr_accessible :type

  # disable STI
  self.inheritance_column = :_type_disabled

  has_many :pages
end
