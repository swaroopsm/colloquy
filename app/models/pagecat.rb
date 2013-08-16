class Pagecat < ActiveRecord::Base
  attr_accessible :title

  # disable STI
  self.inheritance_column = :_type_disabled

  has_many :pages
end
