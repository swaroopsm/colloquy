class AddLongToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :long, :boolean
  end
end
