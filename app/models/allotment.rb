class Allotment < ActiveRecord::Base
  attr_accessible :allotable_id, :allotable_type, :period_id
end
