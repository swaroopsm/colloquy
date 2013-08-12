class Attachment < ActiveRecord::Base
  attr_accessible :pic
  has_attached_file :pic, :styles => {:slide => "800x800>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  belongs_to :attachable, :polymorphic => true
end
